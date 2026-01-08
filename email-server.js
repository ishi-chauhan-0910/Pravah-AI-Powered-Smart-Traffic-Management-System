const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.static(path.join(__dirname)));

// Gmail configuration
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'pravah.commuter@gmail.com',
        pass: 'zfnv pjtf fier okly'
    }
});

// Verify email configuration on startup
transporter.verify(function (error, success) {
    if (error) {
        console.log('❌ Email configuration error:', error.message);
    } else {
        console.log('✅ Email server is ready to send messages');
    }
});

// API endpoint to send email
app.post('/api/send-email', async (req, res) => {
    try {
        const { to, subject, htmlContent, pdfBase64 } = req.body;

        if (!to) {
            return res.status(400).json({ success: false, message: 'Recipient email is required' });
        }

        // Email options
        const mailOptions = {
            from: {
                name: 'PraVah Traffic Management System',
                address: 'pravah.commuter@gmail.com'
            },
            to: to,
            subject: subject || 'PraVah Dashboard Report',
            html: htmlContent || getDefaultEmailHTML(),
            attachments: []
        };

        // Add PDF attachment if provided
        if (pdfBase64) {
            mailOptions.attachments.push({
                filename: 'PraVah_Dashboard_Report.pdf',
                content: pdfBase64,
                encoding: 'base64'
            });
        }

        // Send email
        const info = await transporter.sendMail(mailOptions);
        console.log('✅ Email sent successfully to:', to);
        console.log('   Message ID:', info.messageId);

        res.json({ 
            success: true, 
            message: `Email sent successfully to ${to}`,
            messageId: info.messageId 
        });

    } catch (error) {
        console.error('❌ Error sending email:', error.message);
        res.status(500).json({ 
            success: false, 
            message: 'Failed to send email: ' + error.message 
        });
    }
});

// Default email HTML template
function getDefaultEmailHTML() {
    const date = new Date().toLocaleDateString('en-IN', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });

    return `
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body { font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 20px; }
            .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
            .header { background: linear-gradient(135deg, #2e7d9c, #10b981); padding: 30px; text-align: center; color: white; }
            .header h1 { margin: 0; font-size: 24px; }
            .header p { margin: 10px 0 0; opacity: 0.9; }
            .content { padding: 30px; }
            .kpi-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin: 20px 0; }
            .kpi-card { background: #f8f9fa; padding: 15px; border-radius: 8px; border-left: 4px solid #2e7d9c; }
            .kpi-value { font-size: 24px; font-weight: bold; color: #1a1a2e; }
            .kpi-label { font-size: 12px; color: #666; margin-top: 5px; }
            .footer { background: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #888; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>🚦 PraVah Dashboard Report</h1>
                <p>Odisha State Traffic Management System</p>
            </div>
            <div class="content">
                <p>Dear Recipient,</p>
                <p>Please find attached the latest PraVah Dashboard Report generated on <strong>${date}</strong>.</p>
                
                <h3 style="color: #2e7d9c; border-bottom: 2px solid #eee; padding-bottom: 10px;">📊 Key Highlights</h3>
                <div class="kpi-grid">
                    <div class="kpi-card">
                        <div class="kpi-value">1.8M</div>
                        <div class="kpi-label">Total Vehicles Managed</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">612 tons</div>
                        <div class="kpi-label">CO₂ Emissions Reduced</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">143</div>
                        <div class="kpi-label">Road Accidents Reduced</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">88%</div>
                        <div class="kpi-label">Network Efficiency</div>
                    </div>
                </div>
                
                <p>For detailed information, please refer to the attached PDF report.</p>
                <p>Best regards,<br><strong>PraVah Traffic Management System</strong></p>
            </div>
            <div class="footer">
                <p>This is an automated email from PraVah Traffic Management System</p>
                <p>Odisha State Government</p>
            </div>
        </div>
    </body>
    </html>
    `;
}

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', message: 'Email server is running' });
});

// Start server
app.listen(PORT, () => {
    console.log('');
    console.log('🚀 PraVah Email Server Started');
    console.log(`   Server running at: http://localhost:${PORT}`);
    console.log(`   Dashboard URL: http://localhost:${PORT}/cm_dashboard-2.html`);
    console.log('');
});
