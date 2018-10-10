From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Wed, 10 Oct 2018 08:38:42 +0200
Message-ID: <87d0sii9vx.fsf@gmail.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <87tvlv2wo7.fsf@gmail.com>
        <AM6PR04MB435784E00F0C68A310CD281B97E00@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB435784E00F0C68A310CD281B97E00@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Wed, 10 Oct 2018 02:42:54 +0000")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

>> I am using XSPI mode on LS1021A, talking to a lot of different SPI devices.
>> And they all work, and I believe everything is quite "normal".
>> 
> Since I don't have the board of LS1021, I can't test it. I use other boards
> with DSPI (such as LS1043, LS2088, etc.),
> and I test sp-flash connected on DSPI. If XSPI mode is used at this time, data
> cannot be transmitted normally.

Please describe what happens in much more detailed terms that "cannot be
transmitted normally".  It is simply impossible to assist you when you
report problems in such general terms.

/Esben
