From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Date: Wed, 15 May 2019 08:16:01 +0100
Message-ID: <20190515071601.GQ4319@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-3-git-send-email-masonccyang@mxic.com.tw>
 <20190514065216.GL4319@dell>
 <OF794FCFCD.155B914B-ON482583FB.001EDBB3-482583FB.0020821B@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OF794FCFCD.155B914B-ON482583FB.001EDBB3-482583FB.0020821B@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 15 May 2019, masonccyang@mxic.com.tw wrote:

> Hi Jones,
> 
> 
> > > +
> > > +struct rpc_spi {
> > > +   struct rpc_mfd *mfd;
> > 
> > The term MFD isn't a real thing.  What you're obtaining below is
> > driver data and is normally articulated as 'ddata' in drivers.
> 
> yes, it's just imply that data is from MFD.
> 
> Should I rename "mfd" ?

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
