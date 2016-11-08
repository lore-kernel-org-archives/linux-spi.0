From: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Tue, 8 Nov 2016 10:13:58 -0700
Message-ID: <a86d41da-c7df-4c07-d18e-b751cff9edc7@airwebreathe.org.uk>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de>
 <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
 <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
        moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4bdba358-db18-48f1-3286-a7a7f4c30215-ynQEQJNshbs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Marek,

>>> Should be this way for the sake of readability, fix globally:
>>>
>>>     struct spi_transfer assert_cs_then_reset_delay = {
>>>         .cs_change    = 1,
>>>         .delay_usecs    = ICE40_SPI_FPGAMGR_RESET_DELAY
>>>     };
>>
>> Sure ok. Personally, I prefer it to be concise, but I'm happy to accept
>> the norms.
>
> I prefer it to be readable :)
>

I'll conform to what you're saying.

But I just want to point out that this...


spi_message_add_tail(&(struct spi_transfer){.cs_change = 1,
	.delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY}, &message);


...is clearly more readable than this...


struct spi_transfer assert_cs_then_reset_delay = {
     .cs_change    = 1,
     .delay_usecs  = ICE40_SPI_FPGAMGR_RESET_DELAY
};

....
<30 lines of unrelated code>
....

spi_message_add_tail(&assert_cs_then_reset_delay, &message);



...in my opinion anyway ;)



>> Previously I had a copy of spi_set_cs copy-pasted into my driver, but in
>> the end I decided to replace that with the zero-length transfers because
>> there's a danger that if the original spi_set_cs() gets rewritten some
>> time, my copy-paste code would leave around some nasty legacy.
>>
>> On the whole, I don't think the zero-length transfers are too
>> egregiously bad, and all the alternatives seem worse to me.
>
> So why not turn the CS line into GPIO and just toggle the GPIO?
>

Two reasons.

1. On some devices the CS line is built into the SPI master, rather than 
being a normal GPIO.

2. The SPI driver stack addresses SPI devices in terms of which CS line 
they are attached to. You can't have an spi_device in the kernel where 
the SPI driver machinery doesn't have a CS line to control. Moreover it 
needs to be possible for another SPI device to interrupt a running 
transfer to the FPGA. Supporting this involves the SPI framework 
managing the CS line.



Thanks
Joel


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
