From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
Date: Tue, 4 Aug 2015 11:59:57 +0100
Message-ID: <20150804105957.GI20873@sirena.org.uk>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jnCIwN96y15MEy/K"
Cc: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jnCIwN96y15MEy/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 02:09:56PM +0800, Nicolas Boichat wrote:
> Enabling CONFIG_DEBUG_ATOMIC_SLEEP in kernel configuration, we get
> this warning in spi_gpio_setup:
> [    1.177747] BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:1431
> [    1.190182] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
> [    1.196922] 3 locks held by swapper/0/1:

Please don't include entire stack traces in commit logs, they're
enormous and overwhelm the actual content (like here where the trace is
much bigger than the actual commit message).  If you feel the
information from the trace adds something please present *edited*
highlights instead.

> Actually, I'm not sure if I understand the existing code: why are we not
> waiting for busy to go down to 0, then call chipselect, instead of not calling
> it at all if the bus happens to be busy when we setup the device? With the
> current approach, it would be easy to just use an unconditional mutex_lock.

We shouldn't be blocking waiting for the bus to become free, that's not
how the interface works.

> Also, is it harmful to deactivate the newly setup device in spi_bitbang_setup,
> even if the bus is busy with another device? chipselect should be independent
> for each device (or is it not?). So I'm not clear why we need any locking at
> all...

If you assert chip select on one device while another device is still
being interacted with then the new device will see the traffic for the
old device and become confused.

> Anyway, this patch series does not change the existing behaviour, applies on
> top of broonie-sound/for-next, and, along with the 2 follow-up patches, was
> compile-tested on x86-64/arm (allyesconfig) and ppc44x (defconfig+SPI driver),
> and runtime-tested on an arm platform.

I'm not seeing enough analysis in the commit log of what's being locked
and why - I don't fully understand what the busy stuff is for either
(not that I've looked at the code in detail just now) but I think that's
going to be the key thing here.

--jnCIwN96y15MEy/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwJssAAoJECTWi3JdVIfQAqYH/RKeT+aD3Cl6banO6m/y0zfv
C3Ihg+mZu7ffdzN6tvJ92jCLqzdZyQPnfxhW1l1ed/YsgU6O6EIQqlPEDbCz+VeW
v9JXkp+TA0nZJWxHKaE4XxDhThq7mR33KmkvegqN/L0nGc0S6EsGv4+Z9O0EOUSL
Bt/jBgedOYwy8I/Fng5lp3Gvm1WMrXhazm8k5PTxpovkIy6gJCmq2r0VYdyifR+d
1QBhmK16ksOZT7wZRaUc+6ancmDQR5ONwnmWdmK/x/vtwDdjpN0m697YYVPlc/p2
KbxpQj0jRwxKyrTCYsHEXLoQiUeaMDuOUqB87eQ784T/nozFyV8kxAng3r1rImE=
=EQST
-----END PGP SIGNATURE-----

--jnCIwN96y15MEy/K--
