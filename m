From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Thu, 19 Mar 2015 15:52:27 +0900
Message-ID: <20150319065225.GA30499@verge.net.au>
References: <1426430192-3271-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdX_PrPLh1vyzpd+P=ehCNCPmfqkFVjt4RjjBjT9gOiqFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>,
	Ryo Kataoka <ryo.kataoka.wt@renesas.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX_PrPLh1vyzpd+P=ehCNCPmfqkFVjt4RjjBjT9gOiqFg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Tue, Mar 17, 2015 at 10:28:22AM +0100, Geert Uytterhoeven wrote:
> Hi Kaneko-san, Kataoka-san,
> 
> On Sun, Mar 15, 2015 at 3:36 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >
> > MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> > MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
> 
> "Address 0xE7xx can be accesses only from DMA." was indeed removed.
> However, "Note: Address H'E6xx can be accessed only by CPU." is still
> there in the latest version of the R-Car Gen2 manual I have (v1.01).

Thanks, somehow I miss-read the H'E6xx portion of the manual when
I looked over this patch prior to Kaneko-san posting it.

> Presumably all of this was copied from another SoC (see below)?
>
> MSIOF DMA seems to work fine on my Koelsch (R-Car M2-W ES1.0) with this patch
> (and the DTS changes) applied, though.
>
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> >
> > Hi Geert-san,
> >
> > I have also found patches to address this problem in DTS files
> > which seems to be a good way to handle this problem. I plan to send
> > them separately. I'm unsure if this driver change is also appropriate.
> 
> If there really exist no SoCs where the DMA engine has to access a different
> register set than the CPU, then it can be removed from the driver, and from
> the binding docs in Documentation/devicetree/bindings/spi/sh-msiof.txt.
> 
> However, according to the manuals, SH-Mobile AG5 (sh73a0), R-Mobile APE6
> (r8a73a4), and R-Mobile A1 (r8a7740) also have MSIOF blocks with two register
> banks?

Looking over the documentation for those SoCs, yes that does seem to be the
case. And for the APE6 (I have v0.7 of the manual) it specifies 0xE6xx can
only be accessed by CPU while 0xE7xx can be accessed only from DMA. Unless
that documentation is wrong then it seems to support leaving the driver as is.
