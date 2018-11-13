From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 0/6] spi: pxa2xx: add slave mode support
Date: Tue, 13 Nov 2018 11:22:22 +0100
Message-ID: <20181113102228.820214-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

this patch set adds slave mode support to pxa2xx.

The objective is that it will be able to support the OLPC XO 1.75 embedde=
d
controller that is a SPI master talking to a MMP2 SOC with an extra
"ready" signal for handshaking.

The patches have been submitted previously along with DT support for the
controller which has already been accepted, hence the "v3". These are
the remaining ones. Reviewed/Ack-ed by tags have been collected. Other
changes to the pataches are described in the respective messages.

The EC driver itself is being reviewed in a separate patch set.
=20
Verified on a OLPC XO 1.75 machine.

Thanks to everyone who kindly provided feedback to make the patch set
better.

Thank you,
Lubo
  =20
