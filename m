From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Fri, 4 Apr 2014 11:09:19 +0100
Message-ID: <20140404100919.GO14763@sirena.org.uk>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
 <1396523431-14519-2-git-send-email-harinik@xilinx.com>
 <20140403213446.GB14763@sirena.org.uk>
 <CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q4RbCnAmn9VrkE5p"
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
To: Harini Katakam <harinikatakamlinux@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Q4RbCnAmn9VrkE5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 08:30:38AM +0530, Harini Katakam wrote:
> On Fri, Apr 4, 2014 at 3:04 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 03, 2014 at 04:40:31PM +0530, Harini Katakam wrote:

> >> +Optional properties:
> >> +- num-cs             : Number of chip selects used.

> > How does this translate to the hardware?

> This IP can drive 4 slaves.
> The CS line to be driven is selected in spi device structure and
> that is driven by the software.

So why specify this in the binding at all?  If the device always has the
same number of chip selects it's redundant.

> >> +             num-cs = /bits/ 16 <4>;

> > What's going on with the /bits/ - is this something that's required for
> > the property?

> The master->num-chipselect property is 16 bit but writing <4> here directly
> leads to 0 being read in of_property_read (because it's big endian).
> Instead using of property read u32 and then copying, we decided to do this.
> This was discussed on v2 between Michal and Rob:

No, don't do that.  You're contorting the binding to serve Linux's
implementation needs and you've not documented this requirement either.
If there *was* a need to have the number be 16 bits you'd need to
document that reqirement in the binding, though like I say I don't think
the number needs to be there at all.

--Q4RbCnAmn9VrkE5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPoTMAAoJELSic+t+oim9Do0QAJGUtJJJuayxz+XvkPu4jGtd
IIzTtE4tZ1lwz831Vnig2WbODrmodRSKQyatDW6/b/JxdslXZkYwx6HwXbtmEuZU
yrW2Hfs1fmwnshvxcbrztmbPKpI7o2uTwMDAG26juHJw9SOeR0z7gnCNj+kDctHO
lsajex3O2pck4eYy/xlWOotABNM69lykjFCN/7DE5RGO1f1Ec96FJVcVZ3vsyuJT
o0a0ygDa3j3AUyfiqL/AR/pcocsPKl3F9+S662rWU/+F8u6dWTSKqSg5GadDMaXH
ne4iEPsdPFqOTF2myR0B1oOUOS79t+cnvsEjvPgJbjyqigem/XSD9QCiDxoV5NVA
iug2Ah4qn+EmvbhA/137dDQYRdiL3CapcKVjJ7WH7J4zqiynJ+Ol3/CreAFIf2No
AwLdLTO2Bi+tkK8mloaDyl1MOFAxSVcpZzP1YfNvAg0HH3LU3WFT+oqSEpuqt23u
/29YBs3Z/fT1rsOvJMPsSrwgi3ssp1JizO6WGnhaidTHOCmCLwZIxkwUEuctKFWb
qL4JJQTjaQTVpGi1sYKSB8sLY80ScRayFW2Ifm54Blu1W51WINkpPfpJLgtoT6Y4
yAjp1MW2UpClWa7mj2kIQUHMKUERXm7w4rWOJfNCJFKzPHMDrmkgVx2xJNDSZbEK
wKuBht8zGn+9fU8ZhJrB
=zi3C
-----END PGP SIGNATURE-----

--Q4RbCnAmn9VrkE5p--
