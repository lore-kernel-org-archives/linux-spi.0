From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Fri, 7 Dec 2018 13:01:24 +0100
Message-ID: <8517f472-4981-db32-f5d8-056b70584e86@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
 <93bb36af-8bdb-c90e-3777-62fe1a48f76a@gmail.com>
 <OF0CE74C5C.20959BA6-ON4825835C.0026C7BC-4825835C.0028B3A4@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF0CE74C5C.20959BA6-ON4825835C.0026C7BC-4825835C.0028B3A4@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2018 08:24 AM, masonccyang@mxic.com.tw wrote:
> 
> Hi Marek,

Hi,

>> >> >> > +
>> >> >> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> >> >> > +                 *(u32 *)(tx_buf + pos));
>> >> >>
>> >> >> *(u32 *) cast is probably not needed , fix casts globally.
>> >> >
>> >> > It must have it!
>> >>
>> >> Why ?
>> >
>> > Get a compiler warning due to tx_bug is void *, as Geert replied.
>>
>> The compiler warning is usually an indication that this is something to
>> check, not silence with a type cast.
>>
>> > Using get_unaligned(), patched code would be
>> > -----------------------------------------------------
>> > regmap_write(rpc->regmap, RPC_SMWDR0,
>> >                  get_unaligned((u32 *)(tx_buf + pos)));                
>> > ----------------------------------------------------
>>
>> Do you need the cast if you use get_unaligned() ?
> 
> yes!

Why ? (you can drop one iteration here by explaining why right away,
since I'll ask for that explanation for sure)

>> >> >> > +
>> >> >> > +static const struct regmap_range rpc_spi_volatile_ranges[] = {
>> >> >> > +   regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
>> >> >> > +   regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
>> >> >>
>> >> >> Why is SMWDR volatile ?
>> >> >
>> >> > No matter is write-back or write-through.
>> >>
>> >> Oh, do you want to assure the SMWDR value is always written directly to
>> >> the hardware ?
>> >
>> > yes,
>> >
>> >>
>> >> btw. I think SMRDR should be precious ?
>> >
>> > so, you think I should drop
>> > regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0)
>>
>> No, I am asking whether SMRDR should be marked precious or not.
>>
> 
> I don't think so,
> precious_reg: the register should not be read outside of
> call from driver, i.e,. a clear on read interrupt status register.

If you read the reg outside of the call from driver, it will mess up the
internal FIFO and the whole driver will get into undefined state, right?
Maybe Mark can chime in ?

>> [...]
>>
>> > CONFIDENTIALITY NOTE:
>> >
>> > This e-mail and any attachments may contain confidential information
>> > and/or personal data, which is protected by applicable laws. Please be
>> > reminded that duplication, disclosure, distribution, or use of this
>> > e-mail (and/or its attachments) or any part thereof is prohibited. If
>> > you receive this e-mail in error, please notify us immediately and
>> > delete this mail as well as its attachment(s) from your system. In
>> > addition, please be informed that collection, processing, and/or use of
>> > personal data is prohibited unless expressly permitted by personal data
>> > protection laws. Thank you for your attention and cooperation.
>> >
>> > Macronix International Co., Ltd.
>>
>> Can you do something about this ^ please ?
>>
> 
> I submit the patch file is by another remote git-server, which
> supports git-format patch, git send-mail and so on.
> But it can't receive email.
> 
> I get/send email are by office PC w/ Notes system and
> this "CONFx NOTE:" is appended automatically by Notes mail-server.
> 
> Please just never mind it.

I am concerned MXIC can sue everyone on the CC list of this email based
solely on your suggestion to ignore this paragraph. That's not a good
position to be in.

-- 
Best regards,
Marek Vasut
