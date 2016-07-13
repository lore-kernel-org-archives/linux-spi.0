From: Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH RFCv1 0/1] Update struct spi_transfer to specify 8x bit transfers
Date: Wed, 13 Jul 2016 13:34:36 -0600
Message-ID: <1468438477-18883-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sboyd@codeaurora.org, sdharia@codeaurora.org,
	girishm@codeaurora.org, linux-arm-msm@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We=E2=80=99re working on a driver for a Quad SPI controller [using up t=
o 4 data lines] which can use dual-data-sampling to implement 8-bit tra=
nsfers. To allow a slave driver to specify the 8-bit transfer we'd like=
 to make this change to the spi_transfer data structure. We are still w=
orking on the driver we will send an RFC for the driver patches separat=
ely once it is ready.

Girish Mahadevan (1):
  spi: Expand tx_nbits/rx_nbits to add 8-bit transfer

 include/linux/spi/spi.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Li=
nux Foundation Collaborative Project
