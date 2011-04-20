From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: SPI read problem
Date: Wed, 20 Apr 2011 14:48:00 +0100
Message-ID: <4DAEE410.8020000@cam.ac.uk>
References: <BANLkTi=1svkDQt+HyaHgnann1Vre7CLUNQ@mail.gmail.com>	<BANLkTimFd0ZuP2OQ4A_w7VFbDDN+rsvBtg@mail.gmail.com> <BANLkTi=9dROLwWH2J=Y_FmP+t=rkjMLBJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5b6Q5bu66L6J?= <xujianhui168@gmail.com>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>
To: "Murali K. Vemuri" <vemuri.muralikrishna@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=9dROLwWH2J=Y_FmP+t=rkjMLBJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/20/11 05:40, Murali K. Vemuri wrote:
> On Wed, Apr 20, 2011 at 12:19 PM, =E5=BE=90=E5=BB=BA=E8=BE=89 <xujian=
hui168@gmail.com> wrote:
>> you can use tasklet.
>>
>> 2011/4/19 Murali K. Vemuri <vemuri.muralikrishna@gmail.com>
>>>
>>> Hello there,
>>> I have a device which is Written_to/Read_from using SPI Bus.
>>>
>>> I initialize the device like this:
>>>
>>> static int __init myDEV_init(void)
>>> {
>>>    return spi_register_driver(&myDEV_driver);
>>> }
>>> module_init(myDEV_init);
>>>
>>> My myDEV_probe() function looks like this:
>>>
>>> static int __devinit myDEV_probe(struct spi_device *spi)
>>> {
>>> .....
>>> .....
>>> /*when my CPU receives a particular IRQ, I have to do a spi_read() =
and
>>> do couple of spi_write(), I am using like this:*/
>>> err =3D request_threaded_irq (MY_DEV_IRQ, NULL, myDEV_irq_thread,
>>>            IRQF_TRIGGER_RISING, "MYDEV", NULL);
This should be fine.  The thread can sleep just fine. We do this
all over the place.  Could be something to do with the irq
handling on the device.
>>>
>>> return 0;
>>> }
>>>
>>> When the Interrupt is received by the CPU, myDEV_irq_thread is bein=
g
>>> called.
>>> However, in the ISR I have to do  spi_read(). This is always return=
ing
>>> "Timed out".
That's very suspicious.  What spi controller are we dealing with here?
>>>
>>> To verify if the device is not at all working, along with registeri=
ng
>>> for the IRQ, I also created a char device through I did a IOCTL.
>>> The IOCTL command in turn does spi_read(). In this case spi_read() =
is
>>> successful.
>>>
>>> Since it is necessary to do spi_read() in my ISR, I searched around
>>> and found some information that
>>> spi_read() is callable only from contexts that can sleep.
>>>
>>> How can I make my ISR sleep? or is there any other way of doing thi=
s?
>>>
>>> Any help is highly appreciated.
>>> Thanks & regards
>>> Murali
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>=20
> Hi there,
>=20
> I tried using "tasklet", "workqueue" and semaphore ... all my attempt=
s failed.
> if there is any other method I should try, please let me know.
Something nastier is happening here.  It's not a problem with what you'=
ve
presented in this email.  Perhaps a minimum example of the full code su=
rrounding
the problem may help us diagnose it. =20
