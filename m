From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi:add support for slave function
	in current spi framework
Date: Thu, 10 Feb 2011 09:01:00 -0700
Message-ID: <AANLkTi=Q9WxtfaHAU_0wMpHLipFMDnhZ4O4iNytZUenB@mail.gmail.com>
References: <1296463611-18764-1-git-send-email-Aaron.Wu06@gmail.com>
	<20110202040522.GD29148@angua.secretlab.ca>
	<AANLkTikh3XpMpTqk+=R+==6oDr6hjMq68pzyu5si+WeX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        "Aaron.Wu" <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Aaron Wu <aaronwu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTikh3XpMpTqk+=R+==6oDr6hjMq68pzyu5si+WeX-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 9, 2011 at 7:25 PM, Aaron Wu <aaronwu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Grant,
>
> Just come back from the long holiday. Thanks very much for the comment and
> hints. Following your idea here is some update of our plan:
>
> Yes the slave can not predict when the transaction is going to happen, and
> it takes=A0time before the slave is ready for the transaction after the s=
ystem
> power on, so maybe=A0as a slave we should assert=A0an GPIO to inform the =
master
> that we are=A0ready once we finished the initialization? Then from the
> application level, we issue a=A0blockable read, waitting for the master
> to=A0initiate the=A0transaction.
>
> It's also true that what we do next is highly=A0up to what we get from the
> master, so we plan to=A0put this=A0protocal=A0related strategy to the use=
rspace.
> The application is in charge of=A0analyzing each unit of data=A0the slave
> receives, and=A0take the proper=A0action=A0by calling the slave driver op=
erations.
>
> So basically the slave driver will reside=A0in a sub-directory as you
> suggested, export the read/write and a couple of IOCTLs, it is capable of:
> -- assert an GPIO once it's ready
> -- being=A0configured=A0to operate at different speed, spi_mode 0~3,=A0wo=
rd
> length, etc.
> --=A0read from the master
> -- write to the master
> -- duplex data transaction with the master
>
> It will make use of some of the existing data structures for spi master,
> without cooperating with them. In the board file, there will be a
> slave_spi_board_info, the slave framework will alloc and create related=
=A0spi
> slave device by scanning this table, much the same=A0like=A0how we did fo=
r spi
> master.

I'm really not a fan of the struct spi_board_info approach.  If I were
redesigning the spi infrastructure then I would not use this model.
You'd be better off registering each spi slave instance separately as
platform devices with extra information passed in the platform_data
pointer.

>
> Apart for the common slave driver=A0mentioned above, there will be=A0one=
=A0spi
> slave controller driver file for each of the specific=A0slave controller,
> where the slave operations is implemented=A0for different actual slave
> controller=A0according to=A0their ASIC IP module specification.
>
> The main reason that we plan to through the strategy to user space
> application is because there is no existing standard for the=A0transacted=
 data
> interpretation, this application=A0decide the=A0transaction protocol on b=
ehalf
> of the slave device, representing the=A0master=A0side programmer=A0a
> specification=A0defining=A0the charactor of the slave device.
>
> Need your feed back before moving forward.

I probably won't have much feedback until I actually see an
implementation.  As long as the spi_slave functionality is distinctly
separate from spi master then I don't have any conceptual problems
with it.  It's the shoehorning spi slave mode into the spi master
framework that really bothered me.

g.
