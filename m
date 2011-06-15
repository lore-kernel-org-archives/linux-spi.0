From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/tegra: add devicetree support
Date: Wed, 15 Jun 2011 13:29:11 -0600
Message-ID: <BANLkTimi8n-yik5g=f2jhVQPZoKLuWKgHQ@mail.gmail.com>
References: <20110615190754.11693.26335.stgit@ponder> <74CDBE0F657A3D45AFBB94109FB122FF04992C060C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Erik Gilling <konkers@android.com>
To: Stephen Warren <swarren@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04992C060C@HQMAIL01.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2011 at 1:25 PM, Stephen Warren <swarren@nvidia.com> wr=
ote:
> Grant Likely wrote at Wednesday, June 15, 2011 1:08 PM:
>> Allow the tegra spi driver to obtain populate the spi bus with devic=
es
>
> Remote "obtain"?

heh, oops.

>
>> from the device tree.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> =A0.../devicetree/bindings/spi/spi_nvidia.txt =A0 =A0 =A0 =A0 | =A0 =
=A05 +++++
>> =A0drivers/spi/spi-tegra.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 12 ++++++++++++
>> =A02 files changed, 17 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/spi/spi_nvid=
ia.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi_nvidia.txt b/=
Documentation/devicetree/bindings/spi/spi_nvidia.txt
>> new file mode 100644
>> index 0000000..bde450b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
>> @@ -0,0 +1,5 @@
>> +NVIDIA Tegra 2 SPI device
>> +
>> +Required properties:
>> +- compatible : should be "nvidia,tegra250-spi".
>> +- gpios : should specify GPIOs used for chipselect.
>
> Are things like reg, interrupts, and other general stuff implicit?
> I notice that fsl-spi.txt does specify those, but spi_altera.txt
> and spi_oc_tiny.txt don't.

yeah, standard properties are pretty much implicit.  I don't bother
writing the words if there isn't much value to them.  I've been
contemplating a tool that will take DT documentation written in a
certain form, and automatically fill in standard properties as needed,
but that's a project for another day.

g.
