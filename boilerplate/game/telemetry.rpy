init python:
    if not hasattr(persistent, "telemetry_enabled"):
        persistent.telemetry_enabled = False

label ask_to_share_data:
    "Would you like to share anonymous data with the developers to help improve the game? (You can change this later in Preferences)"
    menu:
        "Yes, share anonymous data":
            $ persistent.telemetry_enabled = True
        "No, don't share any data":
            $ persistent.telemetry_enabled = False
    return

label telemetry_event(event_name):
    python:
        if persistent.telemetry_enabled:
            import urllib.request
            from uuid import uuid4
            import json
            import ssl
            telemetry_id = getattr(persistent, "telemetry_id")
            if not telemetry_id:
                telemetry_id = str(uuid4())
                persistent.telemetry_id = telemetry_id

            try:
                url = "https://pcurxoyfdgwfsbdwogan.supabase.co/functions/v1/record-telemetry"
                data = json.dumps({"game": config.name, "version": config.version, "player_id": persistent.telemetry_id, "platform": renpy.platform ,"event": event_name}).encode("utf-8")
                req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"}, method="POST")
                context = ssl._create_unverified_context()
                with urllib.request.urlopen(req, context=context) as response:
                    response.read()  # Optionally process response
            except Exception as e:
                renpy.log(str(e))
    return