From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: RFC: Working around dynamic device allocation in i2c.  Interaction
 with other subystems.
Date: Thu, 22 Jan 2009 12:55:02 +0000
Message-ID: <49786CA6.8010303@cam.ac.uk>
References: <4974D20F.20209@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4974D20F.20209-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Added spi mailing list (+ likely interested people) as the same approach
is used for device registration as with i2c. 

> Dear All,
> 
> Within board configuration files, i2c devices are currently allocated using
> i2c_board_info structures.  The only element of these that retains it's
> memory address once the struct device elements are allocated (upon adapter
> initialization) is the platform data pointer.
> 
> Several subsystems (regulator and clock for example) use an association
> method based upon a device specific string associated with a pointer to
> a device structure.  Unfortunately as things currently stand there is no
> means of obtaining a suitable device for i2c devices at the point when
> it is required (in the board config).
> 
> So the question is, how to overcome this problem?
> 
> Options that I can come up with are:
> 
> 1) Relax the constraints that the token used for device identification
>    in subsystems using the regulators approach to a void * and use
>    the platform data pointer of an i2c device.  Note this requires
>    every device which may need a regulator to have platform data.
>    Whilst this would work, it is far from ideal.
As Mark Brown pointed out:
This would also remove the ability of the APIs using this to use the
struct device for other things like showing what they're doing in sysfs
or use dev_printk.
> 
> 2) Allow more static allocation of struct i2c_client.  The way of doing
>    this with minimal disruption would be to add a pointer to i2c_board_info
>    to a preallocated i2c_client structure and if this is supplied do not
>    allocate another.  A flag can then be used to indicated whether the
>    structure has been statically allocated or not (thus preventing it
>    being inadvertently freed.
> 
> 3) Allow static allocation of i2c_client structures as a direct alternative
>    to having any i2c_board_info structures at all.  As the majority if not
>    all of i2c_board_info's elements are simply copied into the i2c_client
>    structure anyway, there is considerable overhead in option 2.  Clearly
>    it would not be simple or necessarily advisable to remove i2c_board_info
>    structures so I would propose providing an alternative set of registration
>    functions which would only be used when people cared about the problem
>    we are addressing here.
> 
> What do people think? In particular can anyone come up with any other /
> better way round this issue. (or am I missing something?)
> In particular, are there any similar cases already in kernel that would
> suggest a particular approach to solving this issue?
> 
> I have an implementation of option 2 that works fine and is relatively simple.
> 
> Thanks,
> 
> ---
> Jonathan Cameron
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
