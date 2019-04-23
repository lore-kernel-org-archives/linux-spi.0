From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script
 for SPI5 core"
Date: Tue, 23 Apr 2019 11:02:44 -0300
Message-ID: <CAOMZO5C5Sc0=_Jsb_CW-Vf9_Zka7OaA66uo3OPB4NsHzo92T3A@mail.gmail.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com> <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@peng
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Robin,

On Tue, Apr 23, 2019 at 10:50 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> This reverts commit df07101e1c4a29e820df02f9989a066988b160e6.

You need to provide a detailed explanation in the commit log as to why
the revert is needed.
