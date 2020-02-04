From: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Tue, 4 Feb 2020 10:06:22 -0600
Message-ID: <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
 <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
>>> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
> ...
>
>>>> +       struct device *dev;
>>> Isn't fsl->dev the same?
>>> Perhaps kernel doc to explain the difference?
>>
>> No, it's not the same, as dev here is the SPI controller. I'll add a
>> comment.
> Why to have duplication then?


Nothing is being duplicated, the two variables are storing entirely 
different information, both of which are necessary for each SPI 
controller that this driver is driving.


>
>>>> +       struct fsi_device *fsi;
> ...
>
>>>> +       for (i = 0; i < num_bytes; ++i)
>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
>>> Redundant & 0xffULL part.
>>>
>>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
>>
>> No, these are shift in/out operations. The read register will also have
>> previous operations data in them and must be extracted with only the
>> correct number of bytes.
> Why not to call put_unaligned() how the tail in this case (it's 0 or
> can be easily made to be 0) will affect the result?


The shift-in is not the same as any byte-swap or unaligned operation. 
For however many bytes we've read, we start at that many bytes 
left-shifted in the register and copy out to our buffer, moving right 
for each next byte... I don't think there is an existing function for 
this operation.


>
>>>> +       return num_bytes;
>>>> +}
>>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>>>> +{
>>> Ditto as for above function. (put_unaligned ...)
> Ditto.


I don't understand how this could work for transfers of less than 8 
bytes, any put_unaligned would access memory that it doesn't own.


>
>>>> +}
> ...
>
>>>> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>>>> +                                struct spi_transfer *transfer)
>>>> +{
>>> Can you refactor to tx and rx parts?
>>
>> Why?
> It's way too long function to read. Indentation level also can improve
> readability.
> That's basically what refactoring is for.


The body is 65 lines, I don't think it is too long.

Since the function is used multiple times I think it makes more sense to 
encapsulate the check for tx/rx in the function rather than split it and 
have to check each time the functions are used.


>
>>>> +       return 0;
>>>> +}
> ...
>
>>>> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
>>>> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
>>>> +                         SPI_FSI_CLOCK_CFG_MODE |
>>>> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
>>>> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
>>>> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>>>> +                                      wanted_clock_cfg);
>>> Missed {} ?
>>
>> No? It's one line under the if.
> One statement, but *two* lines.
> What does checkpatch.pl tell you about this?


Right.

checkpatch.pl says nothing about this, I think it meets the coding 
standards as is.


Thanks for the review,

Eddie


>
