From: maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: mcspi
Date: Tue, 8 Apr 2014 14:51:59 +0300
Message-ID: <CAL22ZLJ0k985+z_v5EqWkmWEkR=NSSXV04adA_pL_60tp52bpg@mail.gmail.com>
References: <CAL22ZLJ7qe-=1iH0w1b+G10i9_ERFnFF2oRB7gOatk3k_AhdjQ@mail.gmail.com>
 <20140407125339.GA11339@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407125339.GA11339-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Thanks Gerhard, good idea,  it's working fine for me:)

Best Regards,
Kol

2014-04-07 15:53 GMT+03:00 Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>:
> On Sat, 2014-04-05 at 16:05 +0300, maxim maxim wrote:
>>
>>  I'm working with omap 3 spi driver, in the base I have mcspi driver
>> for tach device(http://processors.wiki.ti.com/index.php/AM335x_McSPI_Driver's_Guide),
>> I want to add my insmod driver for ublox 6(gps device). From ublox6
>> datasheet I saw what I need some initial delay between chip select
>> activation and data sending, I didn't find a way how to do it from
>> Linux SPI Framework, because of this I tried to write directly to some
>> registers what mapped in mcspi driver I can accept their mapped
>> address from contoller_data , but unfortunately it didn't work, may be
>> here you could give me some avices how I can do it.
>
> You might create an SPI message from multiple transfers, where
> the first has no data (length zero) but specifies a delay.  If
> the SPI controller's driver is implemented correctly, or if it
> uses the SPI subsystem's common logic, this should result in the
> desired pause between CS assertion and data transfer.
>
> If it doesn't work out for you (when the driver cuts corners,
> violates the API semantics, or tries to outsmart you), you may
> want to fix that and provide patches. :)
>
>
> virtually yours
> Gerhard Sittig
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
