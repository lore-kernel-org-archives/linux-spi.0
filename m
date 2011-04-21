From: "Murali K. Vemuri" <vemuri.muralikrishna@gmail.com>
Subject: Re: SPI read problem
Date: Thu, 21 Apr 2011 10:15:14 +0900
Message-ID: <BANLkTikGGBCL4wA3gL_W0EaD02yJQDnO9Q@mail.gmail.com>
References: <BANLkTi=1svkDQt+HyaHgnann1Vre7CLUNQ@mail.gmail.com>
	<BANLkTimFd0ZuP2OQ4A_w7VFbDDN+rsvBtg@mail.gmail.com>
	<BANLkTi=9dROLwWH2J=Y_FmP+t=rkjMLBJg@mail.gmail.com>
	<4DAEE410.8020000@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5b6Q5bu66L6J?= <xujianhui168@gmail.com>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>
To: Jonathan Cameron <jic23@cam.ac.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DAEE410.8020000@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 20, 2011 at 10:48 PM, Jonathan Cameron <jic23@cam.ac.uk> wr=
ote:
> On 04/20/11 05:40, Murali K. Vemuri wrote:
>> On Wed, Apr 20, 2011 at 12:19 PM, =E5=BE=90=E5=BB=BA=E8=BE=89 <xujia=
nhui168@gmail.com> wrote:
>>> you can use tasklet.
>>>
>>> 2011/4/19 Murali K. Vemuri <vemuri.muralikrishna@gmail.com>
>>>>
>>>> Hello there,
>>>> I have a device which is Written_to/Read_from using SPI Bus.
>>>>
>>>> I initialize the device like this:
>>>>
>>>> static int __init myDEV_init(void)
>>>> {
>>>> =C2=A0 =C2=A0return spi_register_driver(&myDEV_driver);
>>>> }
>>>> module_init(myDEV_init);
>>>>
>>>> My myDEV_probe() function looks like this:
>>>>
>>>> static int __devinit myDEV_probe(struct spi_device *spi)
>>>> {
>>>> .....
>>>> .....
>>>> /*when my CPU receives a particular IRQ, I have to do a spi_read()=
 and
>>>> do couple of spi_write(), I am using like this:*/
>>>> err =3D request_threaded_irq (MY_DEV_IRQ, NULL, myDEV_irq_thread,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IRQF_TRIGGER_RISING, "MYD=
EV", NULL);
> This should be fine. =C2=A0The thread can sleep just fine. We do this
> all over the place. =C2=A0Could be something to do with the irq
> handling on the device.
>>>>
>>>> return 0;
>>>> }
>>>>
>>>> When the Interrupt is received by the CPU, myDEV_irq_thread is bei=
ng
>>>> called.
>>>> However, in the ISR I have to do =C2=A0spi_read(). This is always =
returning
>>>> "Timed out".
> That's very suspicious. =C2=A0What spi controller are we dealing with=
 here?
>>>>
>>>> To verify if the device is not at all working, along with register=
ing
>>>> for the IRQ, I also created a char device through I did a IOCTL.
>>>> The IOCTL command in turn does spi_read(). In this case spi_read()=
 is
>>>> successful.
>>>>
>>>> Since it is necessary to do spi_read() in my ISR, I searched aroun=
d
>>>> and found some information that
>>>> spi_read() is callable only from contexts that can sleep.
>>>>
>>>> How can I make my ISR sleep? or is there any other way of doing th=
is?
>>>>
>>>> Any help is highly appreciated.
>>>> Thanks & regards
>>>> Murali
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ke=
rnel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>>
>>>
>>
>> Hi there,
>>
>> I tried using "tasklet", "workqueue" and semaphore ... all my attemp=
ts failed.
>> if there is any other method I should try, please let me know.
> Something nastier is happening here. =C2=A0It's not a problem with wh=
at you've
> presented in this email. =C2=A0Perhaps a minimum example of the full =
code surrounding
> the problem may help us diagnose it.
>

Thanks a lot for the inputs. this is the read function I have:
(What  I am trying to do is read register E6 of my device, the
register width is 16 bits.).

static struct spi_device * my_SPI_DEV; (this is populated in the probe =
function)

static int myDEV_read(u8 * buf, u16 len)
{
    int err;
    err =3D spi_read(my_SPI_DEV, buf, len);
    return err;
}
static int read_e6()
{
    u8 buf[3];
    int err;
    buf[0] =3D 0xe6;
    buf[1] =3D 0x00;
    buf[2] =3D 0x00;
    err =3D myDEV_read(buf, 3);
    printk(KERN_ERR "myDEV read returned: %d\n",err);
    return err;
}

Now, this function read_e6() is called from the ISR I mentioned above.

90% of time, the read returns "-5" (I/O Error) and about 10% time it
gets "0".  However I added a little hexdump to check the content in
case the return value is "0". The register content is always "0".

Please let me know if I am doing any mistake.
Thanks & regards
Murali
