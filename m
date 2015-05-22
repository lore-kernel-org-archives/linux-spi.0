From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] MTD: spi-nor: check for short writes in spi_nor_write.
Date: Fri, 22 May 2015 10:37:14 +0100
Message-ID: <20150522093714.GS21577@sirena.org.uk>
References: <cover.1430403750.git.hramrach@gmail.com>
 <50c40ef17ab6566f35ef5a4426bf23567f896db7.1430403750.git.hramrach@gmail.com>
 <20150520233835.GX11598@ld-irv-0074>
 <CAOMqctTYqDWL51twOuGi+oXONXQ4B2-2BkdJNSpzZAXshZUN6g@mail.gmail.com>
 <20150521102802.GS21577@sirena.org.uk>
 <20150522071727.GD23718@brian-ubuntu>
 <20150522072505.GE23718@brian-ubuntu>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AQfDLMJ/cCCv3UHO"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?= <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBVXR7OVAKGQEJ2HKRIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150522072505.GE23718@brian-ubuntu>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--AQfDLMJ/cCCv3UHO
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, May 22, 2015 at 12:25:05AM -0700, Brian Norris wrote:
> On Fri, May 22, 2015 at 12:17:27AM -0700, Brian Norris wrote:

> > Admittedly, as he's using an out-of-tree driver, I'm not
> > sure I know exactly what failure modes he is hitting yet.

> Sorry, I realized I misread here. He's using spi-sunxi. Given that...

> ... is this code even valid?

> static int sun6i_spi_transfer_one(struct spi_master *master,
>                                   struct spi_device *spi,
>                                   struct spi_transfer *tfr)
> {
> ...
> 	/* We don't support transfer larger than the FIFO */
> 	if (tfr->len > SUN6I_FIFO_DEPTH)
> 		return -EINVAL;

> Seems like it should be looping over the transfer in multiple chunks
> instead.

Well, it's not ideal.  Like I say I think that logic probably belongs in
the core rather than individual drivers then we minimise the problems,
if I remember correctly there was the suggestion that the DMA code was
going to follow soon and be used for larger transfers when the original
driver was merged.
--AQfDLMJ/cCCv3UHO--
