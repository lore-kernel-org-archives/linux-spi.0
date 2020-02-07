From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Fri, 7 Feb 2020 13:28:40 -0600
Message-ID: <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
 <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
 <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
>>>>> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
> ...
>
>>>>>> +       struct device *dev;
>>>>> Isn't fsl->dev the same?
>>>>> Perhaps kernel doc to explain the difference?
>>>> No, it's not the same, as dev here is the SPI controller. I'll add a
>>>> comment.
>>> Why to have duplication then?
>>
>> Nothing is being duplicated, the two variables are storing entirely
>> different information, both of which are necessary for each SPI
>> controller that this driver is driving.
> Oh, I see now, thanks!
>
> ...
>
>>>>>> +       for (i = 0; i < num_bytes; ++i)
>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
>>>>> Redundant & 0xffULL part.
>>>>>
>>>>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
>>>> No, these are shift in/out operations. The read register will also have
>>>> previous operations data in them and must be extracted with only the
>>>> correct number of bytes.
>>> Why not to call put_unaligned() how the tail in this case (it's 0 or
>>> can be easily made to be 0) will affect the result?
>>
>> The shift-in is not the same as any byte-swap or unaligned operation.
>> For however many bytes we've read, we start at that many bytes
>> left-shifted in the register and copy out to our buffer, moving right
>> for each next byte... I don't think there is an existing function for
>> this operation.
> For me it looks like
>
>    u8 tmp[8];
>
>    put_unaligned_be64(in, tmp);
>    memcpy(rx, tmp, num_bytes);
>
> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> See, for example, linux/unaligned/be_byteshift.h implementation.


Unforunately it is not the same. put_unaligned_be64 will take the 
highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then 
0x00ff000000000000 into tmp[1], etc. This is only correct for this 
driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes, 
then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into 
tmp[1], etc. So I think my current implementation is correct.


Thanks,

Eddie


>
>>>>>> +       return num_bytes;
>>>>>> +}
>>>>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>>>>>> +{
>>>>> Ditto as for above function. (put_unaligned ...)
>>> Ditto.
>>
>> I don't understand how this could work for transfers of less than 8
>> bytes, any put_unaligned would access memory that it doesn't own.
> Ditto.
>
>>>>>> +}
