From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [DISCUSSION] spi multi chipselect support
Date: Wed, 18 Jul 2018 18:35:30 +0200
Message-ID: <20180718163530.zsa5md3huz3dnotb@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzbhycylfnbjkxy4"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wzbhycylfnbjkxy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Some SPI slave devices have more than one chip select [0]. Rob suggested
to use the following DT notation for this [1]:

spi-controller {
    slave@0 {
        reg = <0>, <1>;
    };
};

I think this makes sense from a DT point of view, but this needs
quite some changes in the SPI core. I tried to find out, how to
implement the suggestion in the last few days and I see two
possibilities:

1. Register two SPI Linux devices from one DT node. This needs the
   fewest changes in SPI core. But we loose the one-to-one mapping
   of DT nodes to devices. I have a feeling, that this will backfire.

2. Add support for multiple chip-select to spi_device and modify
   the transfer functions to make use of this. Unfortunately this
   would require changing all spi controller as far as I can see?

Can you please advise me how to proceed?

Thanks,

-- Sebastian

[0] For example microcontrollers with ISP (in-system programming)
    interface, like the NXP Kinetis K20 series or the MRF89XA,
    which has one chip-select for configuration register access
    and one for FIFO access
[1] https://patchwork.kernel.org/patch/10310109/

--wzbhycylfnbjkxy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltPbE8ACgkQ2O7X88g7
+pq66hAAjxSDnlGBPukpVrvdCJ2cKIgQmiZG3Dn+1jfT71uWsk2hiA6Zolsjyhs+
0KlOT3O4cXQrQvhktLGdCeJZeZpMA/jscZ5PwXefCRN3VngYiWEdlnsMUx8iLYGV
K4MF8dexwae6aXYP6VxCy//XHEyzNrGaz8OJSdOFe8L6e5h6u9xjDPQh9J6VnAzW
gOhW23eGT89ofjl/Wb4SmOn+T+g9BOeBDOtAi4ht2B3gSgXVdlYjHC/B/ufolj0A
f7sfIQ69Bf7ngf71424An6KRsGM+vcvUQwykHgZ2jMRBu5tB+OzyOd5qQNTXUXIu
ym4sS/+as7+W36gZqTfksgVDKyq12OpiG6B2r/v3m+XvO+q8+aF7FXA5ueSFATaS
fHUSkOKZu0ny36fq6MpENisUI1ytDskcx+sTe83tgBL1eu0wzbaF4eCHfMcHIloa
1v5TYuz12NwHhQbX1rnCVWC9l1vkFFL+LVHi8UPuG16sUvpNaGI6V5X1wYAtyQoa
QJR3wyJOVum+xnoonKAmB+x7CHNF1SqJlV4VAaGAym+L+CuHmrgoGTdZuDMtW64k
aQ+4G1u90HZrw+WKzVeQWmdgn1pozNzTn7qMhgs0JQsbDJvCxRzsALiotfh+EzE1
MeM5vCS+UiUvX+Xrp6BbrTtnzXR44ggqlPJpF6yIxZ9zVs/NJGk=
=tC6i
-----END PGP SIGNATURE-----

--wzbhycylfnbjkxy4--
