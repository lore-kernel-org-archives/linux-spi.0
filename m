From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on
 CPM1
Date: Wed, 04 Mar 2015 09:00:39 +0100
Message-ID: <54F6BBA7.8040008@c-s.fr>
References: <20150226161142.D08681A2360@localhost.localdomain> <20150303184403.GE21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150303184403.GE21293@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le 03/03/2015 19:44, Mark Brown a =C3=A9crit :
> On Thu, Feb 26, 2015 at 05:11:42PM +0100, Christophe Leroy wrote:
>> On CPM2, the SPI parameter RAM is dynamically allocated in the dualp=
ort RAM
>> whereas in CPM1, it is statically allocated to a default address wit=
h
>> capability to relocate it somewhere else via the use of CPM micropat=
ch.
>> The address of the parameter RAM is given by the boot loader and exp=
ected
>> to be mapped via of_iomap()
> Why are we using of_iomap() rather than a generic I/O mapping functio=
n
> here?
Euh ...

because all drivers for powerpc seems to be using of_iomap(), as on=20
powerpc the HW is described by the bootloader in a OF device tree.
Today, of_iomap() is at least used in FSL SPI, FSL UART, SPI mpc52xx,=20
UART mpc52xx, i2c-mpc, i2c-cpm, freescale ethernet drivers, etc ....

Is it not correct ?
