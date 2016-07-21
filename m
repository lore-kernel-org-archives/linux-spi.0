From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH v6] ARM: sun4i: spi: Allow transfers larger
 than FIFO size
Date: Thu, 21 Jul 2016 20:03:16 +0200
Message-ID: <34E27D10-C620-4288-A1A8-489B75D4757B@schinagl.nl>
References: <1439062912-4405-1-git-send-email-oliver@schinagl.nl> <20160721112701.GB6610@weiser.dinsnail.net> <20160721163153.GO6509@sirena.org.uk> <20160721172712.GA10640@weiser.dinsnail.net>
Reply-To: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="----PV0WJX9A3TM3OK7YFWTZSAAOFL239S"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org,Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michael Weiser <michael.weiser-Mmb7MZpHnFY@public.gmane.org>,Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDC2JNWXZAJBB3U4YS6AKGQEBGLGWMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160721172712.GA10640-kvmrdUZdB1uagOi/AmBnLNHuzzzSOjJt@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------PV0WJX9A3TM3OK7YFWTZSAAOFL239S
Content-Type: text/plain; charset=UTF-8

As i recall, some claimed it was needed as we have dma now, but i think this patch still scratches the same itch ...

On July 21, 2016 7:27:12 PM CEST, Michael Weiser <michael.weiser-Mmb7MZpHnFY@public.gmane.org> wrote:
>Hi Mark,
>
>On Thu, Jul 21, 2016 at 05:31:53PM +0100, Mark Brown wrote:
>
>> > What is keeping the patch from being merged (i.e. into mainline)?
>> Someone needs to address whatever review comments there were on the
>last
>> version and submit it.
>
>That's my point: There don't seem to be any.
>
>v6 was resend with fixes to checkpatch niggles on v5:
>http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/363073.html
>
>v5 addressed comments by Maxime on v4:
>http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244305.html
>http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/243995.html
>
>I can't find any comments on v5 or v6.
>-- 
>Thanks,
>Michael

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------PV0WJX9A3TM3OK7YFWTZSAAOFL239S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>As i recall, some claimed it was needed as we have=
 dma now, but i think this patch still scratches the same itch ...<br><br><=
div class=3D"gmail_quote">On July 21, 2016 7:27:12 PM CEST, Michael Weiser =
&lt;michael.weiser-Mmb7MZpHnFY@public.gmane.org&gt; wrote:<blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">
<pre class=3D"k9mail">Hi Mark,<br /><br />On Thu, Jul 21, 2016 at 05:31:53P=
M +0100, Mark Brown wrote:<br /><br /><blockquote class=3D"gmail_quote" sty=
le=3D"margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-le=
ft: 1ex;"><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0.=
8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> What is keeping t=
he patch from being merged (i.e. into mainline)?<br /></blockquote> Someone=
 needs to address whatever review comments there were on the last<br /> ver=
sion and submit it.<br /></blockquote><br />That's my point: There don't se=
em to be any.<br /><br />v6 was resend with fixes to checkpatch niggles on =
v5:<br /><a href=3D"http://lists.infradead.org/pipermail/linux-arm-kernel/2=
015-August/363073.html">http://lists.infradead.org/pipermail/linux-arm-kern=
el/2015-August/363073.html</a><br /><br />v5 addressed comments by Maxime o=
n v4:<br /><a
href=3D"http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/24=
4305.html">http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April=
/244305.html</a><br /><a href=3D"http://lists.infradead.org/pipermail/linux=
-arm-kernel/2014-March/243995.html">http://lists.infradead.org/pipermail/li=
nux-arm-kernel/2014-March/243995.html</a><br /><br />I can't find any comme=
nts on v5 or v6.</pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body>=
</html>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------PV0WJX9A3TM3OK7YFWTZSAAOFL239S--
