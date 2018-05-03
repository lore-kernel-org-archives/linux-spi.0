From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for shared
 handler
Date: Thu, 03 May 2018 14:15:32 -0700
Message-ID: <87efiso2yz.fsf@anholt.net>
References: <20180503180945.3502-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5457679589648617855=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Ray Jui <rjui@broadcom.com>,
 Alexander Graf <agraf@suse.de>, linux-spi@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
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

--===============5457679589648617855==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
> DT change which breaks compatibility with older kernels. The AUX irqchip
> was already rejected for upstream[1] and the DT change would break
> working systems if the DTB is updated to a newer one. The latter issue
> was brought to my attention by Alex Graf.
>
> The root cause however is a bug in the shared handler. Shared handlers
> must check that interrupts are actually enabled before servicing the
> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

It looks to me like we'd only return IRQ_HANDLED if we did work that
needed doing.  Is this check effectively doing some interlock to make
sure that we've already started bcm2835aux_spi_transfer_one_irq() and
aren't just racing against transaction setup?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrre/QACgkQtdYpNtH8
nuiTFA/+JXtOPIeC3pRE8QTQu2ZkVPSVHWI3uvV5tmdTxXlgxEDCkAozWMM05InI
NTGg1wdLrmFkBwj5C1iEa2tnAbGAOi8LnlAfhIBkEE32gR0T3hIOLEguzb3Es1zz
LmLOk563jwmX5zCArJ4cu1d7vHMDucfIHFuqlO9d8s32utBRBeMcecpBTKuMEdQp
6v9fZItX2oj5iuI2TRfW5+icBpZ5/67bZ41lk1VSOgIqpkSF/Qsq9SRNOMOHe3R5
DcwETAU8LbNH8XCO+j0PRIC++YLj3fhPJBlwkgQloH0pnLeHzqYqrmx12xuhMnFm
WjWwTR657jL1KUnAiVCDNCBvV5PoorxHw+u1tfWPp0HXJaM9vLfCz/cC/pa+PIoL
5cnIiVeIW1Ry3FOnAkMi4lDrIp8+h6AUYnmf3LxW/W3eUniX8sJwDBbbP5ob0351
Ar/Cbu8lu2uT+fts5w3EVW5CJhQE5dPjfXq2d+K0gvZes2bzhRT+ed8J8GhFl7/z
2XaJ5lIAwB+AM8FUz4s6yFw3pV0NSFPn/WtFlnPL0bQKri3z8sAAcrhHM+dCspF2
PScYMsQwhyoSxsMoC2CtQKIvXxRR9RqrrN6rzEGTRSvc5B035nMNQ468EVqos1eW
VgC7e7DXwTfljoc0DUCuyUFDUGc9kOC+ji3VAseUQ58P2QFUTcY=
=6QOu
-----END PGP SIGNATURE-----
--=-=-=--


--===============5457679589648617855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5457679589648617855==--
