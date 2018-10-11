From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Date: Thu, 11 Oct 2018 11:00:55 +0000
Message-ID: <1539255519-1408-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc@lists.01.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
=20
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
--=20
2.7.4
