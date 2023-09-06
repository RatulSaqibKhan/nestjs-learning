import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Put,
} from '@nestjs/common';
import { CreateUserDto } from './dto/createUserDto';

@Controller('user')
export class UserController {
  /**
   * Endpoint /user/all
   * @returns
   */
  @Get()
  findAll() {
    // Logic to get all users
    return {
      data: 'all users',
      message: 'User data fetched successfully',
    };
  }

  /**
   * Endpoint /user/{id}
   * @param id
   * @returns
   */
  @Get(':id')
  find(@Param('id') id: number) {
    // Logic to find user with the provided identifier
    return {
      user: { id },
      message: 'User data fetched successfully',
    };
  }

  /**
   * Endpoint /user
   * @param createUserDto
   * @returns
   */
  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    // Logic to create a new resource for user using body params
    return {
      data: createUserDto,
      message: 'User data created successfully',
    };
  }

  /**
   * Endpoint /user/{id}
   * @param id
   * @param body
   * @returns
   */
  @Put(':id')
  update(@Param('id') id: number, @Body() body: any) {
    // Logic to update the resource for user having param id
    return {
      data: {
        body,
        id,
      },
      message: 'User data updated successfully',
    };
  }

  /**
   * Endpoint /user/{id}
   * @param id
   * @param body
   * @returns
   */
  @Patch(':id')
  updateName(@Param('id') id: number, @Body('name') name: string) {
    // Logic to update the name of the resource for user having param id
    return {
      data: {
        name,
        id,
      },
      message: "User's name updated successfully",
    };
  }

  @Delete(':id')
  destroy(@Param('id') id: number) {
    // Logic to delete the resource for user having param id
    return {
      data: { id },
      message: `The User having id ${id} is deleted!`,
    };
  }
}
