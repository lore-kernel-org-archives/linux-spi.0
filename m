From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Thu, 10 Nov 2016 13:11:08 +0100
Message-ID: <d2902132-2745-b9f6-5799-ffd3db96941d@denx.de>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de>
 <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
 <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
 <CAAtXAHe_pz=oUpeP+t-Fy0z88LMmTeSffkD2Cbun3r+uTnmGYw@mail.gmail.com>
 <feae0954-7e85-3946-defe-ce252869786d@airwebreathe.org.uk>
 <f7917987-a4cb-2840-8128-07eebd242c17@denx.de>
 <5828eb84-ab29-49e2-34f0-3cd7e527ca66@airwebreathe.org.uk>
 <a580bfa4-7852-aaf8-3a44-24da717f3d51@denx.de>
 <d3af549a-0f68-7511-ad38-b9ec8aab62ca@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>,
        Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d3af549a-0f68-7511-ad38-b9ec8aab62ca-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/09/2016 07:54 PM, Joel Holdsworth wrote:
> On 09/11/16 11:39, Marek Vasut wrote:
>> On 11/09/2016 07:37 PM, Joel Holdsworth wrote:
>>> On 09/11/16 05:01, Marek Vasut wrote:
>>>> On 11/08/2016 06:30 PM, Joel Holdsworth wrote:
>>>>>>>> On the whole, I don't think the zero-length transfers are too
>>>>>>>> egregiously bad, and all the alternatives seem worse to me.
>>>>>>>
>>>>>>> So why not turn the CS line into GPIO and just toggle the GPIO?
>>>>>>
>>>>>> Does that work with *all* SPI controllers?
>>>>>>
>>>>>
>>>>> It does not - no. See my other email.
>>>>
>>>> And is that line an actual CS of that lattice chip or a generic input
>>>> which almost works like CS?
>>>>
>>>
>>> I mean a generic output vs. a special CS output built into the SPI
>>> master of the application processor. Take a look at how spi_set_cs(..)
>>> works:
>>
>> No. I am asking whether the signal which is INPUT on the iCE40 side is
>> really a chipselect signal for the SPI bus OR something which mostly
>> behaves/looks like a chipselect but is not really a chipselect.
> 
> Oh I see. The SS_B line is the SPI SlaveSelect for the configuration port.
> 
> This is the text from the datasheet:
> 
> "SPI Slave Select. Active Low. Includes an internal weak pull-up
> resistor to VCC_SPI during configuration. During configuration, the
> logic level sampled on this pin deter-mines the configuration mode used
> by the iCE40 device. An input when sampled at the start of
> configuration. An input when in SPI Peripheral configuration mode
> (SPI_SS_B = Low). An output when in Master SPI Flash configuration mode."
> 
> So yes - it is a "real" SPI chip-select line.

OK, thanks for checking.

-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
