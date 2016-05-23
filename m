From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Mon, 23 May 2016 11:20:35 +0100
Message-ID: <5742D973.80104@mev.co.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
 <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"3.8+" <stable@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21/05/16 17:50, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2015 at 10:50 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
>> `spidev_message()` sums the lengths of the individual SPI transfers to
>> determine the overall SPI message length.  It restricts the total
>> length, returning an error if too long, but it does not check for
>> arithmetic overflow.  For example, if the SPI message consisted of two
>> transfers and the first has a length of 10 and the second has a length
>> of (__u32)(-1), the total length would be seen as 9, even though the
>> second transfer is actually very long.  If the second transfer specifies
>> a null `rx_buf` and a non-null `tx_buf`, the `copy_from_user()` could
>> overrun the spidev's pre-allocated tx buffer before it reaches an
>> invalid user memory address.  Fix it by checking that neither the total
>> nor the individual transfer lengths exceed the maximum allowed value.
>>
>> Thanks to Dan Carpenter for reporting the potential integer overflow.
>>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> Cc: <stable@vger.kernel.org> # 4.0+
>> ---
>> This could be backported to kernels prior to 4.0, but the total and
>> individual lengths would need to be checked against `bufsiz` instead of
>> `INT_MAX`.
>> ---
>>   drivers/spi/spidev.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
>> index bb6b3ab..23ad978 100644
>> --- a/drivers/spi/spidev.c
>> +++ b/drivers/spi/spidev.c
>> @@ -249,9 +249,10 @@ static int spidev_message(struct spidev_data *spidev,
>>                  total += k_tmp->len;
>>                  /* Since the function returns the total length of transfers
>>                   * on success, restrict the total to positive int values to
>> -                * avoid the return value looking like an error.
>> +                * avoid the return value looking like an error.  Also check
>> +                * each transfer length to avoid arithmetic overflow.
>>                   */
>> -               if (total > INT_MAX) {
>> +               if (total > INT_MAX || k_tmp->len > INT_MAX) {
>
> What if total is INT_MAX - 2 and k_tmp->len is 3? What about total is
> INT_MAX and k_tmp->len is INT_MAX as well? I think the proper check

In your questions, I assume you are referring to the values of 'total' 
before the addition.  I'll call the values 'old_total' and 'new_total' 
(with the same type as 'total', i.e. 'unsigned int').  Note that total 
(and old_total, and new_total) and 'k_tmp->len' have range UINT_MAX, or 
2*INT_MAX+1.

Before the addition, we know that old_total <= INT_MAX (otherwise the 
loop would have errored out already), but k_tmp->len can have any value 
from 0 to UINT_MAX.  After the addition, new_total can have any value 
from 0 to UINT_MAX, and might be less than old_total.  new_total can 
only be less than old_total if old_total + k_tmp->len > UINT_MAX, and 
here I am referring to proper addition, not addition modulo UINT_MAX+1. 
  Rearranging, new_total will be less than old_total if k_tmp->len > 
UINT_MAX - old_total.  Since the maximum value of old_total is INT_MAX, 
the lowest possible value of k_tmp->len that could cause new_total to be 
less than old_total is UINT_MAX - INT_MAX, or INT_MAX+1.  That is what 
the second part of the 'if' test is detecting.

> should be:
>
> if (total < k_tmp->len || total > INT_MAX) {
>          ...
> }
>

That also works.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
