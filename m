From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data
 Mode for SPI
Date: Mon, 13 Feb 2017 12:52:39 +0000
Message-ID: <20170213125239.f5vsxrfwz5t6gqyp@sirena.org.uk>
References: <20170211035447.3819-1-viniciusfre@gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xerefudsf4ytlxj2"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	wens-jdAy2FN1RRM@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBJGYQ3CQKGQERNFQHOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170211035447.3819-1-viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


--xerefudsf4ytlxj2
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Feb 11, 2017 at 12:54:47AM -0300, Vinicius Maciel wrote:
> In order to work appropriately, the max11043 ADC chip and probably
> others, needs SPI master samples the data at the correct edge. From
> max11043 datasheet: "The data at DIN is latched on the rising edge
> of SCLK". Same to DOUT.
> 
> This patch add Master Sample Data Mode bit in normal sample mode.
> It will affect only A20.

This should be controlled by the SPI mode settings, different chips have
different requirements.  If the controller supports multiple modes then
it should expose that and let the drivers and system integrations
choose.
--xerefudsf4ytlxj2--
