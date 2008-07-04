From: Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding
	documentation for SPI busses and devices
Date: Sat, 5 Jul 2008 01:36:58 +0200
Message-ID: <1694b01b1b41f244e565298b430f021c@kernel.crashing.org>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080703010308.26187.23037.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
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

> +    The SPI master node requires the following properties:
> +    - #address-cells  - number of cells required to define a chip 
> select
> +			address on the SPI bus.

Hrm.  Should this (and "reg" in the child node) be required for SPI
masters that have only one chip select?

> +    - max-speed       - (required) Maximum SPI clocking speed of 
> device in Hz

The property name should include something "SPI", it's way too generic
otherwise.

> +    - spi,cpol        - (optional) Device requires inverse clock 
> polarity
> +    - spi,cpha        - (optional) Device requires shifted clock phase

Don't abbr the property names, there's nothing wrong with longer names.
The names shouldn't start with "spi," either, "spi" isn't a vendor;
how about "spi-inverse-clock-polarity" or similar?

> +    - linux,modalias  - (optional, Linux specific) Force binding of 
> SPI device
> +			to a particular spi_device driver.  Useful for changing
> +			driver binding between spidev and a kernel SPI driver.

This is a temporary workaround I hope?


Segher


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
