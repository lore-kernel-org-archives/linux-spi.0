From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
Date: Thu, 20 Dec 2018 09:39:09 +0100
Message-ID: <20181220093909.0e3ad8f1@bbrezillon>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
        <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
        <VI1PR04MB5726FABF724D8EE0144E2C8499BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB5726FABF724D8EE0144E2C8499BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 20 Dec 2018 08:23:07 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Octal mode support patch series has dependency over these patches.
> Should I send these two patches again or specifies them as dependency patches in the cover letter.

No, you should either base your work on the master branch of the
linux-next repo [1] (as suggested by Vignesh) or wait
for 4.21-rc1/5.0-rc1 before sending a new version.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
