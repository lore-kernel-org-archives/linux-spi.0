From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Date: Wed, 27 Mar 2019 14:30:48 +0000
Message-ID: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To: Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I doubt patches 3 and 4 are acceptable, but I'd still like to get
comments and/or alternative suggestions for making large transfers
faster.

The patches have been tested on an MPC8309 with a Cypress S25FL032P
spi-nor slave, and make various operations between 50% and 73%
faster.

We have not observed any problems, but to completely rule out the
possibility of "glitches on SPI CLK" mentioned in patch 3 would of
course require testing on a much wider set of hardware combinations.

Rasmus Villemoes (4):
  spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg
  spi: spi-fsl-spi: relax message sanity checking a little
  spi: spi-fsl-spi: allow changing bits_per_word while CS is still
    active
  spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

 drivers/spi/spi-fsl-spi.c | 41 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

--=20
2.20.1
