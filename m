From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/3] spi: A better solution for cros_ec_spi reliability
Date: Mon, 13 May 2019 13:18:22 -0700
Message-ID: <20190513201825.166969-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series is a much better solution for getting the Chrome OS EC to
talk reliably and replaces commit 37a186225a0c ("platform/chrome:
cros_ec_spi: Transfer messages at high priority").

Specifically note that even though the above commit made things
better, we still saw some failures.

The majority of these failures were because we were competing for time
with dm-crypt which also scheduled work on HIGHPRI workqueues.  While
we can consider reverting the change that made dm-crypt run its work
at HIGHPRI, the argument in commit a1b89132dc4f ("dm crypt: use
WQ_HIGHPRI for the IO and crypt workqueues") is somewhat compelling.
It does make sense for IO to be scheduled at a priority that's higher
than the default user priority.

It turns out that we could also see problems because loop devices also
run at high priority.  See the set_user_nice() in
loop_prepare_queue().

Looking in more detail, it can be seen that the high priority
workqueue isn't actually that high of a priority.  It runs at MIN_NICE
which is _fairly_ high priority but still below all real time
priority.  We can do better by using realtime priority.  That makes
sense because cros_ec_spi actually needs to run quickly for
correctness.  As I understand this is exactly what real time priority
is for.  Note that there is a discussion going on about the dm-crypt
priority [1].

We also had other problems with the previous patch because sometimes
we'd end up on the SPI pumping thread and had our priority downgraded.

Both the competition with other high priority things and the priority
downgrading are fixed by this new series.

After this series I can run the following test on Chrome OS (which
mounts /var as stateful encrypted) with no errors:
  dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
  while true; do
    ectool version > /dev/null;
  done

Special thanks to Guenter Roeck for pointing out the "realtime"
feature of the SPI framework so I didn't re-invent the wheel.  I have
no idea how I missed it.  :-/

Also note: if you want some history on investigation done here, feel
free to peruse the Chrome OS bug [2].

[1] https://lkml.kernel.org/r/CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com
[2] https://crbug.com/948742

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".

Douglas Anderson (3):
  spi: Allow SPI devices to force transfers on a realtime thread
  platform/chrome: cros_ec_spi: Force transfers to realtime priority
  Revert "platform/chrome: cros_ec_spi: Transfer messages at high
    priority"

 drivers/platform/chrome/cros_ec_spi.c | 81 +++------------------------
 drivers/spi/spi.c                     | 49 +++++++++++++---
 include/linux/spi/spi.h               |  5 ++
 3 files changed, 52 insertions(+), 83 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
