From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] devicetree: Add devicetree bindings documentation
 for Zynq Quad SPI
Date: Thu, 3 Apr 2014 11:54:30 -0700
Message-ID: <be8aa6d9-c9a3-4ea8-85fe-d5600e3ff749@TX2EHSMHS019.ehs.local>
References: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local>
 <46a3a23e-786e-4acf-aa42-c3808b1a46d3@CH1EHSMHS028.ehs.local>
 <CAFcVECLoB8BR0PVfV=1EVQub8weOOYustg-1DqOevaihCT3JqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	<broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Punnaiah Choudary <kpc528@gmail.com>,
	<kalluripunnaiahchoudary@gmail.com>,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
	Harini Katakam <harinik@xilinx.com>
To: Harini Katakam <harinikatakamlinux@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFcVECLoB8BR0PVfV=1EVQub8weOOYustg-1DqOevaihCT3JqQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2014-04-04 at 12:15AM +0530, Harini Katakam wrote:
> Hi Soren
>=20
> On Thu, Apr 3, 2014 at 11:20 PM, S=C3=B6ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > Hi Punnaiah,
> >
> > On Thu, 2014-04-03 at 10:33PM +0530, Punnaiah Choudary Kalluri wrot=
e:
> >> Add bindings documentation for Zynq Quad SPI driver.
> >>
> >> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> >> ---
> >>  .../devicetree/bindings/spi/spi-zynq-qspi.txt      |   26 +++++++=
+++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq=
-qspi.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.t=
xt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> >> new file mode 100644
> >> index 0000000..88e00f8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> >> @@ -0,0 +1,26 @@
> >> +Xilinx Zynq QSPI controller Device Tree Bindings
> >> +-------------------------------------------------
> >> +
> >> +Required properties:
> >> +- compatible         : Should be "xlnx,zynq-qspi-1.0".
> >> +- reg                        : Physical base address and size of =
QSPI registers map.
> >> +- interrupts         : Property with a value describing the inter=
rupt
> >> +                       number.
> >> +- interrupt-parent   : Must be core interrupt controller
> >> +- clock-names                : List of input clock names - "ref_c=
lk", "aper_clk"
> >> +                       (See clock bindings for details).
> >> +- clocks             : Clock phandles (see clock bindings for det=
ails).
> >> +
> >> +Optional properties:
> >> +- num-cs             : Number of chip selects used.
> >> +
> >> +Example:
> >> +     qspi@e000d000 {
> >> +             compatible =3D "xlnx,zynq-qspi-1.0";
> >> +             clock-names =3D "ref_clk", "aper_clk";
> >
> > These seem to be the SOC names of the clocks. Doesn't have the IP i=
ts
> > own naming for these clock inputs?
> >
>=20
> The IP design spec uses the name ref_clk.
> There is no particular clock name used for for APB clock.
> So I think aper_clk is a valid name to use.

aper is a Zynq-ism, IMHO. I think 'pclk', 'apbclk' or
something like that is more appropriate.

	S=C3=B6ren


