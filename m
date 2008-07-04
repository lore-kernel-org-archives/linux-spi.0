From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding
	documentation for SPI busses and devices
Date: Fri, 4 Jul 2008 17:42:46 -0600
Message-ID: <fa686aa40807041642m1ecd1f8fr33382076ca5c11fa@mail.gmail.com>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
	<1694b01b1b41f244e565298b430f021c@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Segher Boessenkool" <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1694b01b1b41f244e565298b430f021c-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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

On Fri, Jul 4, 2008 at 5:36 PM, Segher Boessenkool
<segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> wrote:
>> +    The SPI master node requires the following properties:
>> +    - #address-cells  - number of cells required to define a chip select
>> +                       address on the SPI bus.
>
> Hrm.  Should this (and "reg" in the child node) be required for SPI
> masters that have only one chip select?

I suppose it could be skipped, but I'd rather have it there for consistency

>
>> +    - max-speed       - (required) Maximum SPI clocking speed of device
>> in Hz
>
> The property name should include something "SPI", it's way too generic
> otherwise.

Good point; I'll change this to 'spi-max-speed'

>> +    - spi,cpol        - (optional) Device requires inverse clock polarity
>> +    - spi,cpha        - (optional) Device requires shifted clock phase
>
> Don't abbr the property names, there's nothing wrong with longer names.
> The names shouldn't start with "spi," either, "spi" isn't a vendor;
> how about "spi-inverse-clock-polarity" or similar?

Okay, but cpol and cpha are common abbreviations w.r.t. SPI devices.

>> +    - linux,modalias  - (optional, Linux specific) Force binding of SPI
>> device
>> +                       to a particular spi_device driver.  Useful for
>> changing
>> +                       driver binding between spidev and a kernel SPI
>> driver.
>
> This is a temporary workaround I hope?

Yeah, I'm kind of ashamed of this one.  I'll drop it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
