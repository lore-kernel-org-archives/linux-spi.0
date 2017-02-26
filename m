From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data
 Mode for SPI
Date: Sun, 26 Feb 2017 06:10:50 -0800 (PST)
Message-ID: <186c0f31-01d0-4a1b-889b-a390a57bd1d9@googlegroups.com>
References: <20170211035447.3819-1-viniciusfre@gmail.com>
 <20170213125239.f5vsxrfwz5t6gqyp@sirena.org.uk>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_641_968153869.1488118250300"
Cc: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Return-path: <linux-sunxi+bncBDNJJSMB6QFRB26DZPCQKGQEC7BGBLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170213125239.f5vsxrfwz5t6gqyp-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------=_Part_641_968153869.1488118250300
Content-Type: multipart/alternative;
	boundary="----=_Part_642_662790194.1488118250300"

------=_Part_642_662790194.1488118250300
Content-Type: text/plain; charset=UTF-8



Em segunda-feira, 13 de fevereiro de 2017 09:52:53 UTC-3, Mark Brown 
escreveu:
>
> This should be controlled by the SPI mode settings, different chips have 
> different requirements.  If the controller supports multiple modes then 
> it should expose that and let the drivers and system integrations 
> choose. 
>
Do you mean SPI_CPHA/SPI_CPOL, right? Well, I don't know how this mode can 
to fit in existing modes. Since this bit is to control when the data will 
be sampled, in the same clock edge or at the edge that is half cycle 
delayed. That has nothing to do with SPI_CPHA/SPI_CPOL.

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_642_662790194.1488118250300
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>Em segunda-feira, 13 de fevereiro de 2017 09:52:53=
 UTC-3, Mark Brown  escreveu:<blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">T=
his should be controlled by the SPI mode settings, different chips have
<br>different requirements. =C2=A0If the controller supports multiple modes=
 then
<br>it should expose that and let the drivers and system integrations
<br>choose.
<br></blockquote><div>Do you mean=C2=A0<span style=3D"color: rgb(51, 51, 51=
); font-family: SFMono-Regular, Consolas, &quot;Liberation Mono&quot;, Menl=
o, Courier, monospace; font-size: 12px; white-space: pre;">SPI_CPHA/</span>=
<span style=3D"color: rgb(51, 51, 51); font-family: SFMono-Regular, Consola=
s, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 12px;=
 white-space: pre;">SPI_CPOL, right? Well, </span><font color=3D"#333333" f=
ace=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace=
"><span style=3D"font-size: 12px; white-space: pre;">I don&#39;t know how t=
his mode can to fit in existing modes.</span></font>=C2=A0Since this bit is=
 to control when the data will be sampled, in the same clock edge or at the=
 edge that is half cycle delayed. That has nothing to do with=C2=A0<span st=
yle=3D"color: rgb(51, 51, 51); font-family: SFMono-Regular, Consolas, &quot=
;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 12px; white-s=
pace: pre;">SPI_CPHA/</span><span style=3D"color: rgb(51, 51, 51); font-fam=
ily: SFMono-Regular, Consolas, &quot;Liberation Mono&quot;, Menlo, Courier,=
 monospace; font-size: 12px; white-space: pre;">SPI_CPOL.</span></div></div=
>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_642_662790194.1488118250300--

------=_Part_641_968153869.1488118250300--
