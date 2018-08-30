From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5] spi: spi-mem: Adjust op len based on
 message/transfer size limitations
Date: Thu, 30 Aug 2018 11:16:30 +0200
Message-ID: <20180830111630.19ab2fc4@bbrezillon>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
        <20180830104729.5c7fefad@bbrezillon>
        <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 30 Aug 2018 09:13:03 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > Sent: 2018年8月30日 16:47
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v5] spi: spi-mem: Adjust op len based on message/transfer
> > size limitations
> > 
> > Hi Chuanhua,
> > 
> > On Thu, 30 Aug 2018 16:43:24 +0800
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >   
> > > We need that to adjust the len of the 2nd transfer (called data in
> > > spi-mem) if it's too long to fit in a SPI message or SPI transfer.  
> > 
> > You already sent this email a few days back. Please wait a bit before sending it
> > again. And when you do so and nothing changed in the patch please use the
> > [PATCH RESEND vX] prefix and explain why you resend it.  
> I have modified the patch for the comment you mentioned last time. Do you need any other modification？

Oops, sorry. Looks like the previous one was only sent to me, not the
ML and the SPI maintainer.
