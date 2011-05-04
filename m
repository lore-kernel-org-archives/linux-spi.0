From: Jan Andersson <jan-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] spi: add support for aeroflex gaisler spimctrl
Date: Wed, 04 May 2011 16:46:08 +0200
Message-ID: <4DC166B0.4090001@gaisler.se>
References: <1304023295-5829-1-git-send-email-jan@gaisler.com>
	<4DBC09FB.5070406@gaisler.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4DBC09FB.5070406-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 04/30/2011 03:09 PM, Jan Andersson wrote:
> Grant Likely wrote:
>>> +	if (!hw->base) {
>>> +		err = -EBUSY;
>>> +		goto exit;
>>> +	}
>>> +
>>> +	/* check current hw state. if controller is busy, leave it alone */
>>> +	status = ag_spim_read(hw->base + AG_SPIM_STAT);
>>> +	if (status & AG_SPIM_STAT_BUSY) {
>>> +		err = -EBUSY;
>>> +		goto exit_iounmap;
>>> +	}
>>> +
>>> +	/* save control register value to keep settings */
>>> +	hw->ctrl = ag_spim_read(hw->base + AG_SPIM_CTRL);
>>> +
>>> +	/* irq is optional */
>>> +	hw->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>>
>> The irq should already be populated in the platform_device resource
>> table.  You shouldn't need to call irq_of_parse_and_map().
>>
> 
> I tried replacing the call with platform_get_irq() but did not get a
> sensible value back. I am not familiar with how these structures get
> populated. If I would follow how the irq is obtained in other drivers
> for these SoCs I would have done: hw->irq = pdev->archdata.irqs[0];
> 
> I thought the call to irq_of_parse_and_map was cleaner, and the end
> result is the same. If the use of irq_of_parse_and_map is not acceptable
> I will need to dig deeper.
> 

I checked with a colleague who is more familiar with the driver layer
and SPARC port. IORESOURCE_IRQ will not work on SPARC. It looks like the
proper fix for this is to get rid of pdev_archdata in the SPARC port and
change all the SPARC drivers. That will be done but it may take a while
to complete and get it accepted so it would be great if we could allow
the use of irq_of_parse_and_map(pdev->dev.of_node, 0); for the time being.

Best regards,
  Jan

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
