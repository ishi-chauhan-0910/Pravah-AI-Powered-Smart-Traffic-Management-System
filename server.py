import uvicorn
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

app = FastAPI()

# 1. CORS Setup (Essential for your HTML to talk to Python)
# This allows the frontend at port 5500 to send data to port 8000
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins (simplest for development)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 2. Data Model (Matches the data sent from your HTML)
class TripRequest(BaseModel):
    email: str
    destination: str
    departure_time: str
    recommended_time: str
    savings_minutes: int

# 3. Email Configuration
SENDER_EMAIL = "pravah.commuter@gmail.com"  # <--- PUT YOUR EMAIL HERE
SENDER_PASSWORD = "zfnvpjtffierokly" # <--- PUT YOUR APP PASSWORD HERE

@app.post("/schedule_trip")
async def schedule_trip(trip: TripRequest):
    try:
        # Create the email content
        subject = f"Trip Scheduled: {trip.destination}"
        body = f"""
        <html>
          <body>
            <h2>Trip Confirmation</h2>
            <p>You have successfully scheduled a trip to <b>{trip.destination}</b>.</p>
            <ul>
                <li><b>Planned Departure:</b> {trip.departure_time}</li>
                <li><b>Recommended Departure:</b> {trip.recommended_time}</li>
                <li><b>Estimated Time Saved:</b> {trip.savings_minutes} minutes</li>
            </ul>
            <p>Drive safely!</p>
            <p>- Pravah Team</p>
          </body>
        </html>
        """

        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = trip.email
        msg['Subject'] = subject
        msg.attach(MIMEText(body, 'html'))

        # Send the email via Gmail SMTP
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.send_message(msg)
        server.quit()

        print(f"Email sent successfully to {trip.email}")
        return {"status": "success", "message": "Email sent"}

    except Exception as e:
        print(f"Error sending email: {e}")
        return {"status": "error", "message": str(e)}
