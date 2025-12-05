# Screenblanking
I was given the requirement to set a Screen blanking policy across devices, so screensaver activates after 2 minutes of IDLE then computer locks after 5 minutes of IDLE, this is a strategy to balance security with convienience as users were frequently not locking thier devices when leaving thier desks.

The Detection / Remediation script will set the user profile settings required to achieve the following requirements:
 - After 2 minutes of inactivity, active screensaver (the user can wiggle their mouse or press key to wake screen between 2-5 minutes)
 - After 5 minutes of inactivity lock the device (The setting to lock the device is set seperate to these policies) 

 These policies are set in conjunction with a Configuration policy that sets the machine level policies
 Profile type: Administrative Templates
- Turn off the display (plugged in) | Enabled | 0
- Screen saver timeout | Enabled | 120
- Password protect the screen saver | Enabled
- Prevent changing screen saver | Enabled
- Turn off the display (on battery) | Enabled | 0
- MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires | Enabled | 180
- Enable screen saver | Enabled
- Force specific screen saver | Enabled | scrnsave.scr

  Its worth ensuring you review any existing policies for conflicts if you intend to deploy this.
