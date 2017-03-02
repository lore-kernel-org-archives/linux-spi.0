From: Siarhei Siamashka <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data
 Mode for SPI
Date: Thu, 2 Mar 2017 22:44:10 +0200
Message-ID: <20170302224410.31dea7a9@i7>
References: <20170211035447.3819-1-viniciusfre@gmail.com>
	<20170213125239.f5vsxrfwz5t6gqyp@sirena.org.uk>
	<186c0f31-01d0-4a1b-889b-a390a57bd1d9@googlegroups.com>
Reply-To: siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCH4DA7NUEBBBHMI4LCQKGQEQ7ZPTBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <186c0f31-01d0-4a1b-889b-a390a57bd1d9-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On Sun, 26 Feb 2017 06:10:50 -0800 (PST)
Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Em segunda-feira, 13 de fevereiro de 2017 09:52:53 UTC-3, Mark Brown 
> escreveu:
> >
> > This should be controlled by the SPI mode settings, different chips have 
> > different requirements.  If the controller supports multiple modes then 
> > it should expose that and let the drivers and system integrations 
> > choose. 
> >  
> Do you mean SPI_CPHA/SPI_CPOL, right? Well, I don't know how this mode can 
> to fit in existing modes. Since this bit is to control when the data will 
> be sampled, in the same clock edge or at the edge that is half cycle 
> delayed. That has nothing to do with SPI_CPHA/SPI_CPOL.

I'm not sure if it is realistic to make any progress with this issue
any time soon, but I would suggest you to re-send the patch with an
updated commit message, which could better explain what's going on.

I still think that your bugfix is good, that's why you got my
Reviewed-by tag. And we had an older discussion about it (Mark
was not participating there, so probably he missed it):

   https://patchwork.kernel.org/patch/9567547/

Here is a short summary. Older Allwinner A10/A13 SoCs used to have
reserved RAZ/WI (Read-As-Zero, Writes Ignored) bits 20-31 in the
SPI_CTL register. Newer Allwinner A20 SoC introduced some sort of
a wacky half-cycle delay mode and used the previously reserved bit
20 from the SPI_CTL to enable/disable it. Now the tricky part is that
the meaning of this new bit is inverted for some unknown reason: the
wacky mode is activated when the bit is set to zero, while the standard
behaviour (same as A10/A13) is preserved when this bit is set to 1. The
reset default of this bit is 1 on A20 (normal SPI behaviour). The
problem of the current SPI driver is that it clears bits 20-31 of
SPI_CTL, which results in normal SPI behaviour on A10/A13, and a wacky
half-cycle delayed mode on A20. Your bugfix just makes A20 behave in
the same way as A10/A13.

We have exactly zero users of the wacky half-cycle delayed mode.
Moreover, if it gets enabled accidentally (due to a bug in the
SPI_CTL register initialization in the SPI driver as explained
above), then it breaks your max11043 ADC chip. Also even if we
assume that there is some hypothetical equipment, which actually
needs this wacky mode to function preperly, then this equipment
is not compatible with older A10/A13 SoCs because the older SoCs
did not implement this mode at all.

You could rephrase the above two paragraphs and use them as the
commit message for the v3 patch. And maybe also add an extra
comment to the SPI driver code.

If Mark has any comments on this, then I would be very happy
to hear them. So far his suggestion looks like he prefers to
see a support for this wacky mode implemented in the SPI driver
(a *new feature*, which has no actual users and can't be
realistically tested). While your patch just prevents accidental
and undesired activation of the wacky mode (an *important bugfix*
for a real problem encountered in the wild).

-- 
Best regards,
Siarhei Siamashka
