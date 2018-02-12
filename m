From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
Date: Mon, 12 Feb 2018 19:11:59 +0000
Message-ID: <CAKv+Gu9Mb7Wpzwvr=1WsUs1jXYT16DL2dYBfhSWH0HYZMYM5Nw@mail.gmail.com>
References: <20180207160002.GA9292@embeddedgus> <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
 <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com> <CAKv+Gu9VTkNN-6MCCuQ2jWFyDMeZKNRyPqMpTWB5jvuSw7MWeA@mail.gmail.com>
 <bab99bbb-c84b-3413-e7f8-203c7daad8b3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
        Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
        Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bab99bbb-c84b-3413-e7f8-203c7daad8b3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12 February 2018 at 19:10, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 02/12/2018 10:45 AM, Ard Biesheuvel wrote:
>> On 12 February 2018 at 18:04, Gustavo A. R. Silva
>> <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org> wrote:
>>> Hi Ard,
>>>
>>> On 02/08/2018 03:54 AM, Ard Biesheuvel wrote:
>>>>
>>>> On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
>>>> wrote:
>>>>>
>>>>> Add suffix ULL to constant 9 in order to give the compiler complete
>>>>> information about the proper arithmetic to use. Notice that this
>>>>> constant is used in a context that expects an expression of type
>>>>> unsigned long long (64 bits, unsigned).
>>>>>
>>>>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>>>>> using 32-bit arithmetic.
>>>>>
>>>>> Addresses-Coverity-ID: 1339619
>>>>
>>>>
>>>> What does this number mean? If it is an index into some internal
>>>> database, please remove it.
>>>>
>>>
>>> This is a unique Coverity identifier. We want to keep information like
>>> public Bugzilla IDs and tools like Coverity on the commit message.
>>>
>>
>> Who is 'we' in this case? And how is this id to any benefit of other
>> people that have been excluded from 'we'?
>
> We is probably the greater Linux community here.
>
>>
>> If you add identifiers like this, make sure that they don't only make
>> sense to the in-crowd. For instance, you could replace this with a
>> http link to the database entry if you really must.
>
> I don't think it is that easy to extract good URLs from the public Linux
> coverity instance which is why referring to coverity IDs is being done
> AFAICT.

Ah ok, pardon my ignorance then. I wasn't aware there is a public
Linux coverity instance. Got a link?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
