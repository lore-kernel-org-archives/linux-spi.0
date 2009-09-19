From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi: new SPI bus
	lock/unlockfunctions
Date: Sat, 19 Sep 2009 15:11:59 -0400
Message-ID: <8bd0f97a0909191211q4170febfj316d1c0cae31ef5d@mail.gmail.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
	<BD79186B4FD85F4B8E60E381CAEE190901D41E44@mi8nycmail19.Mi8.com>
	<8bd0f97a0909171553s1b7ee725x728bbca2f49511a9@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41FB1@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Yi Li <yi.li@analog.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752320AbZISTMQ@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D41FB1@mi8nycmail19.Mi8.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 18, 2009 at 19:00, H Hartley Sweeten wrote:
> On Thursday, September 17, 2009 3:54 PM, Mike Frysinger wrote:
>>> I assume the spi master driver must supply the {lock/unlock}_bus me=
thods
>>> to properly support the locking.
>>
>> currently, yes. =C2=A0a common solution would be nice. =C2=A0ideas/p=
atches welcome ;).
>>
>>>=C2=A0But, by returning 0 when the methods
>>> are not supplied you are basically saying all the current master dr=
ivers
>>> in mainline support bus locking. =C2=A0I think this is really only =
"true" if
>>> spi->master->num_chipselect =3D=3D 1.
>>
>> right, but that is no different from what we have today. =C2=A0there=
 is no
>> way for a client to guarantee exclusive access, so you cant write co=
de
>> assuming it in the first place. =C2=A0the only consumer thus far (mm=
c_spi)
>> actually errors out if such conditions exist.
>>
>> in other words, we arent breaking anything.
>
> Actually you are breaking the mmc_spi driver.

no we arent.  the current code does some sloppy checking for possible
concurrent access and then aborts.  the new code drops that sloppy
checking in place of the bus master doing it right.  any setup that is
working today will continue to work fine.  and setup *that is already
broken* will continue to be broken.

> By returning 0 when the methods are not supplied you are saying that =
the
> master driver supports and locked the bus. =C2=A0At a minimum, I thin=
k spi_lock_bus()
> should return an error code if locking is not supported.
>
> Also, as Andrew Morton pointed out, calling spi_unlock_bus() without =
having
> a valid lock by calling spi_lock_bus() is a bug.
>
> In addition your patch to mmc_spi should check the return code from
> spi_lock_bus(). =C2=A0If the driver "requires" that the bus be locked=
 it should
> trigger an error path if it cannot be locked.
>
>>> Also, do you have a master driver that does have the {lock/unlock}_=
bus
>>> methods? =C2=A0I would like to see how you handled it.
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3D=
commitdiff;h=3Dcc54fa8ed63e11a000031bc650d41d57b441803d
>
> Oiy... The lock/unlock functions are simple enough but the change nee=
ded
> to bfin_spi_pump_messages() is a bit complicated.
>
> What happens to next_msg if it is for other devices on the bus?

Yi can take a stab at addressing these issues since he is the guy who
has been putting together in the first place.
-mike
