From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Memory-mapped Dwsignware SPI driver
Date: Mon, 18 Jan 2010 13:14:49 -0500
Message-ID: <4B54A519.7030606@octasic.com>
References: <20100118164921.23527.74770.stgit@station520.octasic.com>
	<fa686aa41001180921u3919c3e4u3711097218cbfa7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41001180921u3919c3e4u3711097218cbfa7e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



Grant Likely wrote:
> On Mon, Jan 18, 2010 at 9:50 AM, Jean-Hugues Deschenes
> <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
>   
>> +choice
>> +       prompt "Designware bus type"
>> +       depends on SPI_DESIGNWARE
>> +       default SPI_DW_PCI
>> +
>>  config SPI_DW_PCI
>> -       tristate "PCI interface driver for DW SPI core"
>> -       depends on SPI_DESIGNWARE && PCI
>> +       bool "PCI interface driver for DW SPI core"
>> +       depends on PCI
>> +
>> +config SPI_DW_MMIO
>> +       bool "Memory-mapped io interface driver for DW SPI core"
>> +
>> +endchoice
>>     
>
> The MMIO patch looks non-orthogonal to the PCI stuff so I don't
> understand why a choice/endchoice is being used here.  Is there any
> reason that both bus attachments cannot be compiled as modules at the
> same time?
>   
Aside from the fact that no chip would realistically have both at the 
same time, nope. I'll lift the restriction.
>   
>> --- /dev/null
>> +++ b/drivers/spi/dw_spi_mmio.c
>> @@ -0,0 +1,164 @@
>> +/*
>> + * dw_spi_mmio.c - Memory-mapped interface driver for DW SPI Core
>> + *
>> + * Copyright (c) 2010, Octasic semiconductor.
>> + *
>> + * Somewhat derived from PCI implementation,
>> + * Copyright (c) 2009, Intel Corporation.
>> + *
>> + * ...and from designware i2c driver
>> + * Copyright (C) 2006 Texas Instruments.
>> + * Copyright (C) 2007 MontaVista Software Inc.
>> + * Copyright (C) 2009 Provigent Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation,
>> + * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>>     
>
> Do you really need these three paragraphs of preamble?  IMNSOH, the
> first paragraph stating GPLv2 should be sufficient.
>   
I'm always a bit uncomfortable with the legal stuff, but this code Is 
not very controversial so I guess I can make the preamble lighter...

Thanks!

jh

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
