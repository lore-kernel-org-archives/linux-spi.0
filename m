From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [PATCH] spi: dw: Enable Slave Select with GPIO Chip Select.
Date: Thu, 6 Oct 2016 09:15:02 -0500
Message-ID: <2df0001c-dd59-1352-f5be-a22a9798a357@opensource.altera.com>
References: <1475703538-5018-1-git-send-email-tthayer@opensource.altera.com>
 <20161006093755.kv6tondkeauu5oz2@sirena.org.uk>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <andriy.shevchenko@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <jszhang@marvell.com>,
        <michael@smart-africa.com>, <kernel@mseidel.net>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006093755.kv6tondkeauu5oz2@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/06/2016 04:37 AM, Mark Brown wrote:
> On Wed, Oct 05, 2016 at 04:38:58PM -0500, tthayer@opensource.altera.com wrote:
>
>> This patch adds the Slave Select locally so that the transfer will
>> start and complete. The GPIO CS is taken care of earlier in the SPI
>> framework (spi_set_cs).
>
> This seems like something that other devices might need - it's not the
> first time I heard of a device with the data transfer start and chip
> select being tied together.  Why not make this a generic feature that
> the core implements and drivers can enable?
>
OK. Thanks for the suggestion and review. I'll add a new boolean and 
device tree binding to the SPI core. Thanks.
