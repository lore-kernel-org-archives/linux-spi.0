From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for
 shared handler
Date: Fri, 4 May 2018 08:06:02 +0900
Message-ID: <20180503230602.GA13402@sirena.org.uk>
References: <20180503180945.3502-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8034675562318730107=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Ray Jui <rjui@broadcom.com>,
 Alexander Graf <agraf@suse.de>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180503180945.3502-1-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============8034675562318730107==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 01:09:44PM -0500, Rob Herring wrote:

> The root cause however is a bug in the shared handler. Shared handlers
> must check that interrupts are actually enabled before servicing the
> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

The requirement is more that the handler should correctly identify if it
actually handled an interrupt - especially if the driver doesn't enable
and disable the interrupt at runtime it's not going to upset anything to
always run the interrupt handling (and of course some hardware can't
disable things anyway) but if nohing happened then the handler needs to
return IRQ_NONE.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrldoACgkQJNaLcl1U
h9AFWAf+KJ2Ahu1SNg0uzFnkUt5jMQuqT918CVCyQudsarzgqDIfjNUM1si677MQ
yfiLVaV2FV3ReozK512CnUNAwhGG8ktTYBepOolU+wryZwTbBhFUOF6w2KQQJgm8
E9Cph4D4E8xN4aJ5T3b3po34igFrZSFlasooCw3MfjyXCLPyHY6XDs9znNbpR1QN
g1qayP1SW/PIXS4AqQDO9b4OSJ1e2hnLHh7gnNGfhcOczD8zk2Miol6g/95iexJm
Xf0Yu/I0fTUjQPovnGEhjfxcnF03tt3hVbQEWh1UCQ0RTjJWUcm9IsPghXgbMd3G
7K8quUUIvcpXzODZd+5pkodFUNQuPQ==
=y+hq
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--


--===============8034675562318730107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8034675562318730107==--
