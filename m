From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Tue, 21 Aug 2012 12:30:18 -0700
Message-ID: <5033E1CA.8050107@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
	<1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
	<20120520054657.091DA3E03B8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120520054657.091DA3E03B8@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/19/2012 10:46 PM, Grant Likely wrote:
> On Fri, 11 May 2012 14:34:46 -0700, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> Add the driver, link it into the kbuild system and provide device tree
>> binding documentation.
>>
>> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>
> Some comments below, but you can add my a-b:
>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>
[...]
>> +	p->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
>> +					     resource_size(res_mem));
>
> Nasty cast.  p->register_base needs to be an __iomem pointer
> variable.

No, it is only ever used as an argument to cvmx_{read,write}_csr(),
which want the u64 type.

>  The fact taht cvmx_read_csr accepts a uint64_t instead of
> an __iomem pointer looks really wrong.  Why is it written that way?


Register addresses on OCTEON are 64-bits wide.  In a 32-bit kernel,
pointers are only 32-bits wide.  Thus was born the cvmx_read_csr()
function that takes a u64 address.

We no longer support 32-bit kernels, but the legacy of the interface
lives on.

David Daney


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
