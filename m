From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
Date: Mon, 24 Feb 2020 12:54:09 -0600
Message-ID: <fab0fdf2-6ce7-7635-178e-9bd090d03dc0@linux.vnet.ibm.com>
References: <20200203223003.4567-1-eajames@linux.ibm.com>
 <CAHp75VfHAS46-kMyg7Ky4jn7zmkht6wd9ayCfn+rrO0R6aNr6A@mail.gmail.com>
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
In-Reply-To: <CAHp75VfHAS46-kMyg7Ky4jn7zmkht6wd9ayCfn+rrO0R6aNr6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 2/4/20 5:05 AM, Andy Shevchenko wrote:
> On Tue, Feb 4, 2020 at 12:30 AM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>> There exists a set of SPI controllers on some POWER processors that may
>> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
>> engine that can access and drive the SPI controllers. This driver would
>> typically be used by a baseboard management controller (BMC).
>>
>> The SPI controllers operate by means of programming a sequencing engine
>> which automatically manages the usual SPI protocol buses. The driver
>> programs each transfer into the sequencer as various operations
>> specifying the slave chip and shifting data in and out on the lines.
> Some comments left unsettled in v1, thus applicable here.


I think I addressed all of Andy's comments on v1 now, if Andy agreed 
about leaving the byte shifting as-is in fsi_spi_data_in/out.


Thanks,

Eddie


>
