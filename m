From: "Murali K. Vemuri" <vemuri.muralikrishna@gmail.com>
Subject: Re: SPI read problem
Date: Fri, 22 Apr 2011 21:22:57 +0900
Message-ID: <BANLkTikci6aT=8aVnZ5sHc3mE=tQJk=ZNg@mail.gmail.com>
References: <BANLkTi=1svkDQt+HyaHgnann1Vre7CLUNQ@mail.gmail.com>
	<BANLkTimFd0ZuP2OQ4A_w7VFbDDN+rsvBtg@mail.gmail.com>
	<BANLkTi=9dROLwWH2J=Y_FmP+t=rkjMLBJg@mail.gmail.com>
	<4DAEE410.8020000@cam.ac.uk>
	<BANLkTikGGBCL4wA3gL_W0EaD02yJQDnO9Q@mail.gmail.com>
	<BANLkTik95F6qeo13KmZ+oZ19YHkxtL15uQ@mail.gmail.com>
	<BANLkTimo4BV5H-dMw4=P8KrsY7czR9a4mQ@mail.gmail.com>
	<BANLkTinnXPR_tmyK4HASpKD8Ze+T40eA+w@mail.gmail.com>
	<4DB0169D.80901@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pei Lin <telent997@gmail.com>,
	=?GB2312?B?0Oy9qLvU?= <xujianhui168@gmail.com>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>
To: Jonathan Cameron <jic23@cam.ac.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DB0169D.80901@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2011/4/21 Jonathan Cameron <jic23@cam.ac.uk>:
> On 04/21/11 12:30, Murali K. Vemuri wrote:
>> 2011/4/21 Murali K. Vemuri <vemuri.muralikrishna@gmail.com>:
>>> 2011/4/21 Pei Lin <telent997@gmail.com>:
>>>> 2011/4/21 Murali K. Vemuri <vemuri.muralikrishna@gmail.com>:
>>>>> On Wed, Apr 20, 2011 at 10:48 PM, Jonathan Cameron <jic23@cam.ac.=
uk> wrote:
>>>>>> On 04/20/11 05:40, Murali K. Vemuri wrote:
>>>>>>> On Wed, Apr 20, 2011 at 12:19 PM, =D0=EC=BD=A8=BB=D4 <xujianhui=
168@gmail.com> wrote:
>>>>>>>> you can use tasklet.
>>>>>>>>
>>>>>>>> 2011/4/19 Murali K. Vemuri <vemuri.muralikrishna@gmail.com>
>>>>>>>>>
>>>>>>>>> Hello there,
>>>>>>>>> I have a device which is Written_to/Read_from using SPI Bus.
>>>>>>>>>
>>>>>>>>> I initialize the device like this:
>>>>>>>>>
>>>>>>>>> static int __init myDEV_init(void)
>>>>>>>>> {
>>>>>>>>>    return spi_register_driver(&myDEV_driver);
>>>>>>>>> }
>>>>>>>>> module_init(myDEV_init);
>>>>>>>>>
>>>>>>>>> My myDEV_probe() function looks like this:
>>>>>>>>>
>>>>>>>>> static int __devinit myDEV_probe(struct spi_device *spi)
>>>>>>>>> {
>>>>>>>>> .....
>>>>>>>>> .....
>>>>>>>>> /*when my CPU receives a particular IRQ, I have to do a spi_r=
ead() and
>>>>>>>>> do couple of spi_write(), I am using like this:*/
>>>>>>>>> err =3D request_threaded_irq (MY_DEV_IRQ, NULL, myDEV_irq_thr=
ead,
>>>>>>>>>            IRQF_TRIGGER_RISING, "MYDEV", NULL);
>>>>>> This should be fine.  The thread can sleep just fine. We do this
>>>>>> all over the place.  Could be something to do with the irq
>>>>>> handling on the device.
>>>>>>>>>
>>>>>>>>> return 0;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> When the Interrupt is received by the CPU, myDEV_irq_thread i=
s being
>>>>>>>>> called.
>>>>>>>>> However, in the ISR I have to do  spi_read(). This is always =
returning
>>>>>>>>> "Timed out".
>>>>>> That's very suspicious.  What spi controller are we dealing with=
 here?
>>>>>>>>>
>>>>>>>>> To verify if the device is not at all working, along with reg=
istering
>>>>>>>>> for the IRQ, I also created a char device through I did a IOC=
TL.
>>>>>>>>> The IOCTL command in turn does spi_read(). In this case spi_r=
ead() is
>>>>>>>>> successful.
>>>>>>>>>
>>>>>>>>> Since it is necessary to do spi_read() in my ISR, I searched =
around
>>>>>>>>> and found some information that
>>>>>>>>> spi_read() is callable only from contexts that can sleep.
>>>>>>>>>
>>>>>>>>> How can I make my ISR sleep? or is there any other way of doi=
ng this?
>>>>>>>>>
>>>>>>>>> Any help is highly appreciated.
>>>>>>>>> Thanks & regards
>>>>>>>>> Murali
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe lin=
ux-kernel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Hi there,
>>>>>>>
>>>>>>> I tried using "tasklet", "workqueue" and semaphore ... all my a=
ttempts failed.
>>>>>>> if there is any other method I should try, please let me know.
>>>>>> Something nastier is happening here.  It's not a problem with wh=
at you've
>>>>>> presented in this email.  Perhaps a minimum example of the full =
code surrounding
>>>>>> the problem may help us diagnose it.
>>>>>>
>>>>>
>>>>> Thanks a lot for the inputs. this is the read function I have:
>>>>> (What  I am trying to do is read register E6 of my device, the
>>>>> register width is 16 bits.).
>>>>>
>>>>> static struct spi_device * my_SPI_DEV; (this is populated in the =
probe function)
>>>>>
>>>>> static int myDEV_read(u8 * buf, u16 len)
>>>>> {
>>>>>    int err;
>>>>>    err =3D spi_read(my_SPI_DEV, buf, len);
>>>>>    return err;
>>>>> }
>>>>> static int read_e6()
>>>>> {
>>>>>    u8 buf[3];
>>>>>    int err;
>>>>>    buf[0] =3D 0xe6;
>>>>>    buf[1] =3D 0x00;
>>>>>    buf[2] =3D 0x00;
>>>>>    err =3D myDEV_read(buf, 3);
>>>>>    printk(KERN_ERR "myDEV read returned: %d\n",err);
>>>>>    return err;
>>>>> }
>>>>>
>>>>> Now, this function read_e6() is called from the ISR I mentioned a=
bove.
>>>>>
>>>>
>>>>
>>>> spi_read will call spi_sync and this call may only be used from a
>>>> context that may sleep.  The sleep
>>>>  is non-interruptible, and has no timeout. should use in
>>>> non-interruptable context.
>>>> you should put the spi_read on context which can sleep, as bottom =
half
>>>> "work queue"
>>>> Or use spi_async interface.
>>>>
>>> I added "workqueue", and got the same result. Also, I used "tasklet=
"
>>> and got the same result.
>>> spi_async does not seem to be working for me, returning EINVAL (-22=
).
>>> spi_sync() seem to be returning 0 (supposed to be success) but no d=
ata
>>> coming out ... still investigating why ZEROS are returned instead o=
f
>>> valid data.
>>>
>>> if you have any suggestions, please let me know.
>>>
>>> Murali
>>>>
>>>>> 90% of time, the read returns "-5" (I/O Error) and about 10% time=
 it
>>>>> gets "0".  However I added a little hexdump to check the content =
in
>>>>> case the return value is "0". The register content is always "0".
>>>>>
>>>>> Please let me know if I am doing any mistake.
>>>>> Thanks & regards
>>>>> Murali
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-k=
ernel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards
>>>> Lin
>>>>
>>>
>> Okay, finally dug about and found that My chip was expecting the rea=
d
>> command in different style and I am sending in different style.
>> my spi_read() has to send only one byte (the register address ) on t=
he
>> SIMO line and expect 2 bytes on the SOMI line.
>> I used a load of debug prints to find that my code (as below) is
>> providing the two bytes of space on SIMO line itself. So, what chang=
es
>> are needed in this code to read correctly?
>>
>> static struct spi_device * my_SPI_DEV; (this is populated in the pro=
be function)
>>
>> static int myDEV_read(u8 * buf, u16 len)
>> {
>>    int err;
>>    err =3D spi_read(my_SPI_DEV, buf, len);
>>    return err;
>> }
>> static int read_e6()
>> {
>>    u8 buf[3];
>>    int err;
>>    buf[0] =3D 0xe6;
>>    buf[1] =3D 0x00;
>>    buf[2] =3D 0x00;
>>    err =3D myDEV_read(buf, 3);
>>    printk(KERN_ERR "myDEV read returned: %d\n",err);
>>    return err;
>> }
>
> int a =3D spi_w8r16(my_sPI_DEV, 0xe6);
>
> a should contain your result, or a negative if an
> error occurs.
>
>

hmmm ..  spi_w8r16() is returning 0 always for me.
I tested the case in which the device must return a valid value for
the register (0xE6) content.
there are only two registers which I can read on my device, (e6-16
bits long & E5 - 8 bits long).
tried the spi_w8r8() with the E5 register and same result.

any ideas ? BTW, I am using OMAP as my CPU and I don't see any other
device using the SPI.
Murali
Th
