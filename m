From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Date: Mon, 10 Dec 2018 09:50:42 +0100
Message-ID: <20181210095042.354d422f@bbrezillon>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
        <20181205134618.56223758@bbrezillon>
        <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206074554.0ec0aecb@bbrezillon>
        <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206202956.GG3084@sirena.org.uk>
        <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210092208.0971c3be@bbrezillon>
        <VI1PR04MB572609DBC52F7496A656915E99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
In-Reply-To: <VI1PR04MB572609DBC52F7496A656915E99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 10 Dec 2018 08:39:20 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> Sorry for confusion.
> 
> My intention was just to point to the correct patch number only. Earlier you have asked Mark to pick the patch [1] but that patch number was not correct.

Look at the context in [1] (we have good reasons to reply inline instead
of top-posting). I asked Mark to pick "spi: nxp-fspi: add octal mode
flag bit for octal support", not the m25p80 changes. I was wrong
though, as the patch I pointed to depends on your nxp-fspi patchset
which as not been merged yet.

> 
> [1] https://lkml.org/lkml/2018/12/5/758
