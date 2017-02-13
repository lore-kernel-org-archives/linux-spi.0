From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/sun6i: Add Master Sample Data Mode for SPI
Date: Mon, 13 Feb 2017 16:00:09 -0300
Message-ID: <CAEz5UgEAYB94mC-6Oste4-tRRq16iXqBnJmjjhQFkqDmVO-nog@mail.gmail.com>
References: <20170213120553.6479-1-viniciusfre@gmail.com> <20170213183430.65vbm3cubid2ljkv@sirena.org.uk>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a114b5b4872e15505486e0e9e
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDNJJSMB6QFRBOUERDCQKGQE2CIMW6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170213183430.65vbm3cubid2ljkv-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--001a114b5b4872e15505486e0e9e
Content-Type: text/plain; charset=UTF-8

Hi Mark,

Sorry for the mess up. sun6i is a reference to the Allwinner A31 processor
and sun7i is a reference to the Allwinner A20 processor. A31 uses
spi-sun6i.c code, while A20 uses spi-sun4i.c code. Therefore, this is a
different patch.
About your recommedantion, I have to check with Maxine what can be done.

Thanks.

2017-02-13 15:34 GMT-03:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> On Mon, Feb 13, 2017 at 09:05:53AM -0300, Vinicius Maciel wrote:
> > In order to work appropriately, some SPI chips, such as
> > max11043, require SPI master samples the data at the
> > correct edge.
>
> As I said on another version of this patch this should really be done by
> implementing the SPI modes - there isn't one universal configuration for
> SPI devices unfortunately.
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--001a114b5b4872e15505486e0e9e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mark,<div><br></div><div><div>Sorry for the mess up. su=
n6i is a reference to the Allwinner A31 processor and sun7i is a reference =
to the Allwinner A20 processor. A31 uses spi-sun6i.c code, while A20 uses s=
pi-sun4i.c=C2=A0code. Therefore, this is a different patch.=C2=A0</div><div=
>About your recommedantion, I have to check with Maxine what can be done.</=
div></div><div><br></div><div>Thanks.</div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">2017-02-13 15:34 GMT-03:00 Mark Brown <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" target=3D"_blank">br=
oonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Mon, Feb 13, 2017 at 09:05:53AM -0300, Vinicius Maciel wrote:<b=
r>
&gt; In order to work appropriately, some SPI chips, such as<br>
&gt; max11043, require SPI master samples the data at the<br>
&gt; correct edge.<br>
<br>
</span>As I said on another version of this patch this should really be don=
e by<br>
implementing the SPI modes - there isn&#39;t one universal configuration fo=
r<br>
SPI devices unfortunately.<br>
</blockquote></div><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a114b5b4872e15505486e0e9e--
