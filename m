From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Mon, 19 May 2008 23:13:48 -0600
Message-ID: <fa686aa40805192213y485c4ba2u750748f8201e0377@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
	<fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
	<Pine.LNX.4.64.0805191811510.29559@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Guennadi Liakhovetski" <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0805191811510.29559-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 19, 2008 at 10:30 AM, Guennadi Liakhovetski
<g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> On Mon, 19 May 2008, Grant Likely wrote:
>> But that is Linux internal
>> details; this discussion is about device tree bindings.
>>
>> Note that I did say that drivers can define additional properties for
>> supporting chip select changes as needed.  I'm just not attempting to
>> encode them into the formal binding.  There is simply just too many
>> different ways to manipulate chip select signals and so I don't feel
>> confident trying to define a *common* binding at this moment in time.
>
> Yes, I understand, that physically there can be many ways SPI chipselects
> can be controlled. But I thought there could be a generic way to cover
> them all by defining a separate entry on your SPI bus. Like
>
> +    SPI example for an MPC5200 SPI bus:
> +               spi@f00 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> +                       reg = <0xf00 0x20>;
> +                       interrupts = <2 13 0 2 14 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +                       eth-switch-cs@0 {
> +                               compatible = "oem,cs-type";
> +                       };
> +
> +                       ethernet-switch@0 {
> +                               compatible = "micrel,ks8995m";
> +                               linux,modalias = "ks8995";
> +                               max-speed = <1000000>;
> +                               reg = <0>;
> +                               cs-parent = <&/.../spi@f00/eth-switch-cs@0>;
> +                       };
> ...
> +               };
>
> Then whatever method is used to actually switch the CS, a driver should be
> registered to handle eth-switch-cs@0, providing the required calls.
> Without such a driver ethernet-switch@0 will not probe successfully.
> Wouldn't this cover all possible cases? One could even consider actually
> putting SPI devices on SPI chipselect busses, but that won't look very
> elegant:-)

Hurrmmmm...

I'm not so fond of this approach.  cs-parent doesn't seem to make much
sense to me.  It might be better to have a cs-handler property on the
SPI bus node instead of on the SPI slave nodes, but even then it
leaves a number of questions about what it really means.  In some
cases it would be overkill.  For example, if the SPI node simply had
multiple GPIO lines then an extra cs-parent node wouldn't be needed at
all.  Then there are the complex arrangements.  When setting CS
requires inserting a special 'set cs' SPI message at the right time.
Or worse; when setting CS requires /modifying/ the sent SPI message.
Essentially, the binding would need to describe the ability to
completely intercept and rewrite all SPI messages going through the CS
scheme.

I'm not saying it's not possible to do, but I am saying that I'd like
to have a better feel for all the use cases before it is defined.  I'm
not convinced that adding a cs-parent phandle will do that
appropriately.  That being said, my gut feel is that the solution will
be to support spi-bridge nodes that handle the complex CS
configuration settings; the spi-bridge would be a child of the
spi-master and the parent of the spi devices; and simple CS settings
being handled with regular old GPIO bindings.  (Much like the last
suggestion you make; except that I think that it *does* looks
elegant.)  :-)

example; here's an SPI bus that has 2 GPIOs for two bus CS lines and
an SPI bridge that uses both CSes; one address for accessing the
bridge's CS register and one CS to access the downstream devices.

+    SPI example for an MPC5200 SPI bus:
+               spi@f00 {
+                   #address-cells = <1>;
+                   #size-cells = <0>;
+                   compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+                   reg = <0xf00 0x20>;
+                   interrupts = <2 13 0 2 14 0>;
+                   interrupt-parent = <&mpc5200_pic>;
+                   gpios = <&gpio1 0 0 &gpio1 1 0>;
+                   spi-bridge@0 {
+                       compatible = "oem,spi-bridge-type";
+                       reg = < 0 1 >;  // note: 2 SPI CS addresses;
first one to access bridge registers
+
+                       ethernet-switch@0 {
+                           compatible = "micrel,ks8995m";
+                           linux,modalias = "ks8995";
+                           max-speed = <1000000>;
+                           reg = <0>;
+                       };
...                     // and more SPI child nodes here...
+                   };
+               };

But even this doesn't reflect the hardware layout well.  What if the
SS lines are on SPI GPIO expanders on the same bus?  Then does it make
sense for them to be layed out as spi bridges?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
