From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 0/8] Add interconnect support to QSPI and QUP drivers
Date: Fri, 13 Mar 2020 18:42:06 +0530
Message-ID: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

dt-binding patch for QUP drivers.
 - https://patchwork.kernel.org/patch/11436621/ [Convert QUP bindings
	to YAML and add ICC, pin swap doc]

dt-binding patch for QSPI.
 - https://patchwork.kernel.org/patch/11436719/ [Convert QSPI binding
	to YAML and add interconnect doc]

High level design:
 - QUP wrapper/common driver.
   Vote for QUP core on behalf of earlycon from probe.
   Remove BW vote during sys suspend call

 - SERIAL driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from qcom_geni_serial_pm func.
   Bump up the CPU vote from set_termios call based on real time need

 - I2C driver.
   Vote for CORE/CPU/DDR path
   Vote/unvote from runtime resume/suspend callback
   As bus speed for I2C is fixed from probe itself no need for bump up.

 - SPI QUP driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.

 - QSPI driver.
   Vote only for CPU path
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.


Changes in V2:
 - Add devm_of_icc_get() API interconnect core.
 - Add ICC support to common driver to fix earlyconsole crash.

Akash Asthana (8):
  interconnect: Add devm_of_icc_get() as exported API for users
  soc: qcom: geni: Support for ICC voting
  soc: qcom-geni-se: Add interconnect support to fix earlycon crash
  tty: serial: qcom_geni_serial: Add interconnect support
  i2c: i2c-qcom-geni: Add interconnect support
  spi: spi-geni-qcom: Add interconnect support
  spi: spi-qcom-qspi: Add interconnect support
  arm64: dts: sc7180: Add interconnect for QUP and QSPI

 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 127 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c    | 110 +++++++++++++++++++++++++++++
 drivers/interconnect/core.c           |  25 +++++++
 drivers/soc/qcom/qcom-geni-se.c       |  41 +++++++++++
 drivers/spi/spi-geni-qcom.c           |  74 +++++++++++++++++++-
 drivers/spi/spi-qcom-qspi.c           |  46 +++++++++++-
 drivers/tty/serial/qcom_geni_serial.c |  69 ++++++++++++++++--
 include/linux/interconnect.h          |   7 ++
 include/linux/qcom-geni-se.h          |  28 ++++++++
 9 files changed, 521 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
