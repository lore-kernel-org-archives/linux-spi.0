From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] spi/pxa2xx: Clear cur_chip pointer before starting next message
Date: Fri, 05 Dec 2014 19:36:41 +0100
Message-ID: <87r3wex7t2.fsf@free.fr>
References: <1417425166-150374-1-git-send-email-mika.westerberg@linux.intel.com>
	<87egsfyvsd.fsf@free.fr> <20141205082429.GF1306@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Martin Oldfield <m@mjoldfield.com>,
	linux-kernel@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141205082429.GF1306@lahna.fi.intel.com> (Mika Westerberg's
	message of "Fri, 5 Dec 2014 10:24:29 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Thu, Dec 04, 2014 at 10:01:06PM +0100, Robert Jarzmik wrote:
>> So with your change, we have :
>>   	drv_data->cur_chip = NULL;
>> 	spi_finalize_current_message(drv_data->master);
>> 
>> In that case, if spi_finalize_current_message() queues another message, upon
>> this next message completion, won't giveback() be called, and dereference
>> cur_chip as well ?
>
> When the next message is started pxa2xx_spi_transfer_one_message() gets
> called and that will set cur_chip again.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
