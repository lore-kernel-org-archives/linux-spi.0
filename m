From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Thu, 6 Dec 2018 10:19:10 +0100
Message-ID: <c7fe7eb3-b13d-2e90-12de-3edeadd9d5b0@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWEiOTSSM=rKu67r-kgJ=TyAi7p7ndhAS4d5-6gccmmoQ@mail.gmail.com>
 <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
 <2c6c23fc-299a-f64d-c81f-4b4123f1577b@gmail.com>
 <OF62002C8B.5D0A4315-ON4825835B.0031F545-4825835B.003310A3@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF62002C8B.5D0A4315-ON4825835B.0031F545-4825835B.003310A3@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/06/2018 10:17 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> >> > +
>> >> > +       pm_runtime_enable(&pdev->dev);
>> >> > +       master->auto_runtime_pm = true;
>> >> > +
>> >> > +       master->num_chipselect = 1;
>> >> > +       master->mem_ops = &rpc_spi_mem_ops;
>> >> > +       master->transfer_one_message = rpc_spi_transfer_one_message;
>> >>
>> >> Is there any reason you cannot use the standard
>> >> spi_transfer_one_message, i.e. provide spi_controller.transfer_one()
>> >> instead of spi_controller.transfer_one_message()?
>> >>
>> >
>> > It seems there is a RPC HW restriction in CS# pin control.
>> > Therefore, it can't send the 1'st spi-transfer for command and then
>> > keeping CS# pin goes low for the 2'nd spi-transfer for address/data and
>> > so on.
>>
>> Isn't register DRCR bit SSLN/SSLE exactly for this purpose ?
>>
> 
> DRCR is for RPC module works in external space read mode, using memcpy( ).
> It is not for _spi_sync().
> 
> I only could use manual I/O mode by SMCR@bit-8 SSLKP and I found it has
> some
> restrictions in manual I/O mode to control CS# pin.

What restrictions are those ? I am aware of some, maybe there is more.

-- 
Best regards,
Marek Vasut
