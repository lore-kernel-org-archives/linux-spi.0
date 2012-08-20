From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND v4] spi/pl022: add devicetree support
Date: Mon, 20 Aug 2012 08:07:45 -0500
Message-ID: <503236A1.6090809@gmail.com>
References: <1345462769-17386-1-git-send-email-aletes.xgr@gmail.com>
	<50323464.4070006@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	"Mark Brown \(broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org\)"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <50323464.4070006-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/20/2012 07:58 AM, Roland Stigge wrote:
> Hi all,
> 
> On 08/20/2012 01:39 PM, Alexandre Pereira da Silva wrote:
>> Add the chipselect array and cur_cs properties to pl022 main structure
>>
>> Add a wrapper function to decide if the cs should be controlled by the
>> cs_control callback or the chipselect gpio
>>
>> Populate chipselect property from cs-gpios
>>
>> Populate master->dev.of_node, so the spi bus can find child spi
>> devices and register them
>>
>> At pl022 setup, fill chip_data structure from dt nodes, if not provided
>> by platform.
>>
>> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Acked-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
> 
> We somehow missed 3.6 with this one. Would be nice to have it in 3.7 now
> since it's useful for mach-lpc32xx when it's available.

Mark Brown is handling SPI right now for Grant, so please send it to
him. I have some comments on the patch though.

Rob

> 
> If there are any open issues, I can assist Alexandre on this patch.
> 
> Thanks in advance,
> 
> Roland
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
